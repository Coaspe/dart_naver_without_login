import 'dart:convert';

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
