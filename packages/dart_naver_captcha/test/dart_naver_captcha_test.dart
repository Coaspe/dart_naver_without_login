import 'package:dart_naver_captcha/dart_naver_captcha.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    NaverWithoutLoginApi.init(clientId: 'id', clientSecret: 'secret');
  });

  test('issues and verifies an image CAPTCHA key', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/v1/captcha/nkey');
      if (request.url.queryParameters['code'] == '0') {
        return http.Response('{"key":"captcha-key"}', 200);
      }
      expect(request.url.queryParameters['key'], 'captcha-key');
      expect(request.url.queryParameters['value'], 'ABC123');
      return http.Response('{"result":true,"responseTime":4.2}', 200);
    });

    final key = await CaptchaApi.issueImageKey(client: client);
    final result = await CaptchaApi.verify(
      CaptchaType.image,
      key: key.key,
      value: 'ABC123',
      client: client,
    );

    expect(result.result, isTrue);
    expect(result.responseTime, 4.2);
  });

  test('downloads audio CAPTCHA bytes', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/v1/captcha/scaptcha');
      expect(request.url.queryParameters, {'key': 'key'});
      return http.Response.bytes([82, 73, 70, 70], 200);
    });

    final bytes = await CaptchaApi.challenge(
      CaptchaType.audio,
      key: 'key',
      client: client,
    );

    expect(bytes, [82, 73, 70, 70]);
  });

  test('covers audio key operations and image download', () async {
    final paths = <String>{};
    final client = MockClient((request) async {
      paths.add(request.url.path);
      if (request.url.path.endsWith('/ncaptcha.bin')) {
        return http.Response.bytes([1], 200);
      }
      if (request.url.queryParameters['code'] == '0') {
        return http.Response('{"key":"key"}', 200);
      }
      return http.Response('{"result":false}', 200);
    });

    final key = await CaptchaApi.issueAudioKey(client: client);
    await CaptchaApi.verify(
      CaptchaType.audio,
      key: key.key,
      value: '1234',
      client: client,
    );
    await CaptchaApi.challenge(CaptchaType.image, key: 'key', client: client);

    expect(paths, {'/v1/captcha/skey', '/v1/captcha/ncaptcha.bin'});
  });
}
