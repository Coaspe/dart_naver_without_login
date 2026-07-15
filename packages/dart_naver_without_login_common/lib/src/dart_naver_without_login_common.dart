import 'dart:convert';

import 'package:crypto/crypto.dart';

/// A class representing the NaverWithoutLoginApi.
///
/// This class provides methods and properties for interacting with the Naver API without login.
class NaverWithoutLoginApi {
  NaverWithoutLoginApi._();

  static final NaverWithoutLoginApi _instance = NaverWithoutLoginApi._();

  factory NaverWithoutLoginApi() => _instance;

  static String? clientId;
  static String? clientSecret;

  /// Initializes the NaverWithoutLoginApi with the provided [clientId] and [clientSecret].
  ///
  /// Throws an [ArgumentError] if [clientId] or [clientSecret] is empty.
  static void init({required String clientId, required String clientSecret}) {
    if (clientId.isEmpty || clientSecret.isEmpty) {
      throw ArgumentError("Client ID and client secret must not be empty.");
    }
    NaverWithoutLoginApi.clientId = clientId;
    NaverWithoutLoginApi.clientSecret = clientSecret;
  }
}

/// Credentials for APIs provided through NAVER Cloud Platform.
class NaverCloudApi {
  NaverCloudApi._();

  static String? _clientId;
  static String? get clientId => _clientId;

  static String? _clientSecret;
  static String? get clientSecret => _clientSecret;

  /// Initializes NAVER Cloud Platform API credentials.
  ///
  /// Throws an [ArgumentError] if [clientId] or [clientSecret] is empty.
  static void init({required String clientId, required String clientSecret}) {
    if (clientId.isEmpty || clientSecret.isEmpty) {
      throw ArgumentError("Client ID and client secret must not be empty.");
    }
    _clientId = clientId;
    _clientSecret = clientSecret;
  }
}

/// Credentials for NAVER Cloud APIs that use IAM HMAC authentication.
class NaverCloudIamApi {
  NaverCloudIamApi._();

  static String? _accessKey;
  static String? get accessKey => _accessKey;

  static String? _secretKey;

  /// Initializes NAVER Cloud IAM credentials.
  static void init({required String accessKey, required String secretKey}) {
    if (accessKey.isEmpty || secretKey.isEmpty) {
      throw ArgumentError('Access key and secret key must not be empty.');
    }
    _accessKey = accessKey;
    _secretKey = secretKey;
  }

  /// Creates the `x-ncp-apigw-signature-v2` value for a request.
  static String createSignature({
    required String method,
    required Uri uri,
    required String timestamp,
  }) {
    final accessKey = _accessKey;
    final secretKey = _secretKey;
    if (accessKey == null || secretKey == null) {
      throw StateError('NAVER Cloud IAM credentials must be initialized.');
    }

    final path = uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path;
    final message = '${method.toUpperCase()} $path\n$timestamp\n$accessKey';
    final digest = Hmac(
      sha256,
      utf8.encode(secretKey),
    ).convert(utf8.encode(message));
    return base64Encode(digest.bytes);
  }
}
