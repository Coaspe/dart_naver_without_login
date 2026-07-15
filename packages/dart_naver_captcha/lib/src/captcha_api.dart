import 'dart:typed_data';

import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class CaptchaApi {
  CaptchaApi._();

  static const _baseUrl = 'https://openapi.naver.com/v1/captcha';

  static Future<CaptchaKeyResponse> issueKey(
    CaptchaType type, {
    Map<String, String>? headers,
    http.Client? client,
  }) => ApiUtil.requestApiWithoutLogin(
    _keyUri(type, {'code': '0'}),
    CaptchaKeyResponse.fromJson,
    headers: headers,
    client: client,
  );

  static Future<CaptchaVerificationResponse> verify(
    CaptchaType type, {
    required String key,
    required String value,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validate(key, 'key');
    _validate(value, 'value');
    return ApiUtil.requestApiWithoutLogin(
      _keyUri(type, {'code': '1', 'key': key, 'value': value}),
      CaptchaVerificationResponse.fromJson,
      headers: headers,
      client: client,
    );
  }

  /// Returns JPEG bytes for image CAPTCHA or WAV bytes for audio CAPTCHA.
  static Future<Uint8List> challenge(
    CaptchaType type, {
    required String key,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validate(key, 'key');
    final path = switch (type) {
      CaptchaType.image => 'ncaptcha.bin',
      CaptchaType.audio => 'scaptcha',
    };
    final uri = Uri.parse(
      '$_baseUrl/$path',
    ).replace(queryParameters: {'key': key}).toString();
    return ApiUtil.requestBytes(uri, headers: headers, client: client);
  }

  static Future<CaptchaKeyResponse> issueImageKey({
    Map<String, String>? headers,
    http.Client? client,
  }) => issueKey(CaptchaType.image, headers: headers, client: client);

  static Future<CaptchaKeyResponse> issueAudioKey({
    Map<String, String>? headers,
    http.Client? client,
  }) => issueKey(CaptchaType.audio, headers: headers, client: client);

  static String _keyUri(CaptchaType type, Map<String, String> parameters) {
    final path = switch (type) {
      CaptchaType.image => 'nkey',
      CaptchaType.audio => 'skey',
    };
    return Uri.parse(
      '$_baseUrl/$path',
    ).replace(queryParameters: parameters).toString();
  }

  static void _validate(String value, String name) {
    if (value.isEmpty) {
      throw ArgumentError.value(value, name, '$name must not be empty.');
    }
  }
}
