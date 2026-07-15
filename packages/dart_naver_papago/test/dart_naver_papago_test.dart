import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_naver_papago/dart_naver_papago.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    NaverCloudApi.init(clientId: 'cloud-id', clientSecret: 'cloud-secret');
    NaverWithoutLoginApi.init(
      clientId: 'developers-id',
      clientSecret: 'developers-secret',
    );
    NaverCloudIamApi.init(accessKey: 'iam-access', secretKey: 'iam-secret');
  });

  test('translates text through the current NAVER Cloud endpoint', () async {
    var requestCount = 0;
    final client = MockClient((request) async {
      requestCount++;
      expect(request.url.toString(), ServerHost.papagoTranslation);
      expect(request.headers['X-NCP-APIGW-API-KEY-ID'], 'cloud-id');
      expect(request.headers['X-NCP-APIGW-API-KEY'], 'cloud-secret');
      expect(request.bodyFields, {
        'source': 'ko',
        'target': 'en',
        'text': '안녕하세요',
      });
      return http.Response(
        '{"message":{"result":{"srcLangType":"ko",'
        '"tarLangType":"en","translatedText":"Hello"}}}',
        200,
      );
    });

    final response = await PapagoTranslation.getTranslation(
      LangCode.ko,
      LangCode.en,
      '안녕하세요',
      client: client,
    );

    expect(response.getText, 'Hello');
    expect(requestCount, 1);
  });

  test('detects every language supported by the current API', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), ServerHost.languageDetection);
      expect(request.bodyFields, {'query': 'नमस्ते'});
      return http.Response('{"langCode":"hi"}', 200);
    });

    final response = await LanguageDetection.detectLanguage(
      'नमस्ते',
      client: client,
    );

    expect(response.langCode, LangCode.hi);
  });

  test('rejects an unsupported translation pair before requesting', () {
    expect(
      PapagoTranslation.getTranslation(LangCode.it, LangCode.en, 'ciao'),
      throwsArgumentError,
    );
  });

  test('sends every current text translation option', () async {
    final client = MockClient((request) async {
      expect(request.bodyFields, {
        'source': 'en',
        'target': 'ko',
        'text': 'Hello',
        'glossaryKey': 'glossary',
        'replaceInfo': 'replace',
        'honorific': 'true',
      });
      return http.Response.bytes(
        utf8.encode(
          '{"message":{"result":{"srcLangType":"en",'
          '"tarLangType":"ko","translatedText":"안녕하세요"}}}',
        ),
        200,
      );
    });

    await PapagoTranslation.getTranslation(
      LangCode.en,
      LangCode.ko,
      'Hello',
      glossaryKey: 'glossary',
      replaceInfo: 'replace',
      honorific: true,
      client: client,
    );
  });

  test('supports document translation, status, and download', () async {
    final client = MockClient((request) async {
      if (request.url.path.endsWith('/translate')) {
        expect(request.headers['X-NCP-APIGW-API-KEY-ID'], 'cloud-id');
        expect(
          request.headers['content-type'],
          startsWith('multipart/form-data'),
        );
        return http.Response('{"data":{"requestId":"request-1"}}', 200);
      }
      if (request.url.path.endsWith('/status')) {
        expect(request.url.queryParameters['requestId'], 'request-1');
        return http.Response(
          '{"data":{"status":"COMPLETE","progressPercent":100}}',
          200,
        );
      }
      return http.Response.bytes(
        [1, 2, 3],
        200,
        headers: {
          'content-type': 'application/pdf',
          'content-disposition': 'attachment; filename="translated.pdf"',
        },
      );
    });

    final request = await DocumentTranslation.translate(
      LangCode.ko,
      LangCode.en,
      Uint8List.fromList([1, 2]),
      fileName: 'document.pdf',
      client: client,
    );
    final status = await DocumentTranslation.status(
      request.requestId,
      client: client,
    );
    final file = await DocumentTranslation.download(
      request.requestId,
      client: client,
    );

    expect(status.status, DocumentTranslationStatus.complete);
    expect(file.fileName, 'translated.pdf');
    expect(file.bytes, [1, 2, 3]);
  });

  test('translates website HTML', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), ServerHost.papagoWebsiteTranslation);
      expect(request.bodyFields['html'], '<p>Hello</p>');
      expect(request.bodyFields['glossaryKey'], 'glossary');
      return http.Response.bytes(
        utf8.encode('{"status_code":200,"data":"<p>안녕하세요</p>"}'),
        200,
      );
    });

    final result = await WebsiteTranslation.translate(
      LangCode.en,
      LangCode.ko,
      '<p>Hello</p>',
      glossaryKey: 'glossary',
      client: client,
    );
    expect(result.html, '<p>안녕하세요</p>');
  });

  test('creates and manages glossary terms with IAM signing', () async {
    final client = MockClient((request) async {
      expect(request.headers['x-ncp-iam-access-key'], 'iam-access');
      expect(request.headers['x-ncp-apigw-signature-v2'], isNotEmpty);
      if (request.url.path.endsWith('/create')) {
        return http.Response('{"data":{"glossaryKey":"glossary"}}', 200);
      }
      if (request.method == 'POST') {
        return http.Response.bytes(
          utf8.encode(
            '{"replacers":[{"id":1,"glossaryKey":"glossary",'
            '"source":"ko","target":"en","triggerText":"사과",'
            '"replaceText":"apple","createdDateTime":"now"}]}',
          ),
          200,
        );
      }
      return http.Response('', 204);
    });

    final glossary = await GlossaryApi.create('테스트', client: client);
    final terms = await GlossaryApi.addTerms([
      GlossaryTermInput(
        glossaryKey: glossary.glossaryKey,
        source: 'ko',
        target: 'en',
        triggerText: '사과',
        replaceText: 'apple',
      ),
    ], client: client);
    await GlossaryApi.deleteTerms('glossary', [1], client: client);

    expect(terms.terms.single.id, 1);
  });

  test('calls every remaining glossary operation', () async {
    final calls = <String>{};
    final client = MockClient((request) async {
      calls.add('${request.method} ${request.url.path}');
      expect(request.headers['x-ncp-apigw-signature-v2'], isNotEmpty);
      if (request.url.path.endsWith('/upload')) {
        return http.Response(
          '{"data":{"glossaryKey":"glossary","glossaryName":"name"}}',
          200,
        );
      }
      if (request.url.path.endsWith('/download')) {
        return http.Response.bytes([80, 75], 200);
      }
      if (request.url.path.endsWith('/glossary/v1/')) {
        return http.Response(
          '{"data":[],"currentPage":1,"totalPage":0,'
          '"currentGlossaryCount":0,"totalGlossaryCount":0}',
          200,
        );
      }
      if (request.method == 'GET' && request.url.path.endsWith('/replacer')) {
        return http.Response(
          '{"replacerList":[],"paging":{"totalPageCount":0,'
          '"totalItemCount":0,"page":1,"count":20}}',
          200,
        );
      }
      if (request.method == 'PATCH') {
        return http.Response('{"replacers":[]}', 200);
      }
      return http.Response('{"data":{"glossaryKey":"glossary"}}', 200);
    });

    await GlossaryApi.upload(
      'glossary',
      Uint8List.fromList([1]),
      client: client,
    );
    await GlossaryApi.download('glossary', client: client);
    await GlossaryApi.list(client: client);
    await GlossaryApi.listTerms('glossary', client: client);
    await GlossaryApi.updateTerms([
      GlossaryTermUpdate(glossaryKey: 'glossary', id: 1, replaceText: 'pear'),
    ], client: client);
    await GlossaryApi.delete('glossary', client: client);

    expect(calls, contains('POST /glossary/v1/glossary/upload'));
    expect(calls, contains('POST /glossary/v1/glossary/download'));
    expect(calls, contains('GET /glossary/v1/'));
    expect(calls, contains('GET /glossary/v1/glossary/replacer'));
    expect(calls, contains('PATCH /glossary/v1/replacer'));
    expect(calls, contains('DELETE /glossary/v1/glossary'));
  });

  test('translates images to text and rendered image', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), ServerHost.papagoImageToImage);
      expect(
        request.headers['content-type'],
        startsWith('multipart/form-data'),
      );
      return http.Response.bytes(
        utf8.encode(
          '{"data":{"sourceLang":"en","targetLang":"ko",'
          '"sourceText":"Hello","targetText":"안녕하세요",'
          '"blocks":[],"renderedImage":"AQID"}}',
        ),
        200,
      );
    });

    final response = await ImageTranslation.translateToImage(
      LangCode.en,
      LangCode.ko,
      Uint8List.fromList([1, 2, 3]),
      fileName: 'image.png',
      client: client,
    );

    expect(response.data.targetText, '안녕하세요');
    expect(response.data.renderedImageBytes, [1, 2, 3]);
  });

  test('uses the image-to-text endpoint', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), ServerHost.papagoImageToText);
      return http.Response(
        '{"data":{"sourceLang":"en","targetLang":"ko",'
        '"sourceText":"Hello","targetText":"Hello","blocks":[]}}',
        200,
      );
    });

    await ImageTranslation.translateToText(
      LangCode.en,
      LangCode.ko,
      Uint8List.fromList([1]),
      fileName: 'image.jpg',
      client: client,
    );
  });

  test('romanizes a name with NAVER Developers credentials', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/v1/krdict/romanization');
      expect(request.url.queryParameters, {'query': '강형욱'});
      expect(request.headers['X-Naver-Client-Id'], 'developers-id');
      return http.Response.bytes(
        utf8.encode(
          '{"aResult":[{"sFirstName":"강형욱","aItems":['
          '{"name":"Gang Hyeonguk","score":"99"}]}]}',
        ),
        200,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
    });

    final response = await Romanization.romanization('강형욱', client: client);

    expect(response.aResult.single.aItems.single.name, 'Gang Hyeonguk');
  });
}
