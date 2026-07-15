import 'dart:convert';

import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    NaverWithoutLoginApi.init(
      clientId: 'developers-id',
      clientSecret: 'developers-secret',
    );
    NaverCloudApi.init(clientId: 'cloud-id', clientSecret: 'cloud-secret');
    NaverCloudIamApi.init(
      accessKey: 'iam-access-key',
      secretKey: 'iam-secret-key',
    );
  });

  test('rejects empty credentials', () {
    expect(
      () => NaverWithoutLoginApi.init(clientId: '', clientSecret: 'secret'),
      throwsArgumentError,
    );
    expect(
      () => NaverCloudApi.init(clientId: 'id', clientSecret: ''),
      throwsArgumentError,
    );
    expect(
      () => NaverCloudIamApi.init(accessKey: '', secretKey: 'secret'),
      throwsArgumentError,
    );
  });

  test('creates a deterministic NAVER Cloud IAM signature', () {
    final signature = NaverCloudIamApi.createSignature(
      method: 'GET',
      uri: Uri.parse('https://example.com/glossary/v1?page=1'),
      timestamp: '1700000000000',
    );

    expect(signature, isNotEmpty);
    expect(base64Decode(signature), hasLength(32));
  });

  test('returns binary response bytes', () async {
    final client = MockClient((_) async => http.Response.bytes([1, 2, 3], 200));

    final result = await ApiUtil.requestBytes(
      'https://example.com/image',
      client: client,
    );

    expect(result, [1, 2, 3]);
  });

  test('sends NAVER Developers credentials with a JSON request', () async {
    final client = MockClient((request) async {
      expect(request.method, 'POST');
      expect(request.headers['X-Naver-Client-Id'], 'developers-id');
      expect(request.headers['X-Naver-Client-Secret'], 'developers-secret');
      expect(jsonDecode(request.body), {'query': 'hello'});
      return http.Response('{"value":"ok"}', 200);
    });

    final result = await ApiUtil.requestApiWithoutLogin(
      'https://example.com/json',
      (json) => json['value'] as String,
      requestMethod: RequestMethod.post,
      body: {'query': 'hello'},
      client: client,
    );

    expect(result, 'ok');
  });

  test('sends NAVER Cloud credentials with a form request', () async {
    final client = MockClient((request) async {
      expect(request.headers['X-NCP-APIGW-API-KEY-ID'], 'cloud-id');
      expect(request.headers['X-NCP-APIGW-API-KEY'], 'cloud-secret');
      expect(request.bodyFields, {'query': '안녕하세요'});
      return http.Response('{"langCode":"ko"}', 200);
    });

    final result = await ApiUtil.requestApiWithoutLogin(
      'https://example.com/form',
      (json) => json['langCode'] as String,
      requestMethod: RequestMethod.post,
      authType: ApiAuthType.naverCloud,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'query': '안녕하세요'},
      client: client,
    );

    expect(result, 'ko');
  });

  test('throws a typed exception for an unsuccessful response', () async {
    final client = MockClient(
      (_) async => http.Response('{"error":"forbidden"}', 403),
    );

    expect(
      ApiUtil.requestApiWithoutLogin(
        'https://example.com/error',
        (json) => json,
        client: client,
      ),
      throwsA(
        isA<NaverApiException>()
            .having((error) => error.statusCode, 'statusCode', 403)
            .having((error) => error.body, 'body', contains('forbidden')),
      ),
    );
  });
}
