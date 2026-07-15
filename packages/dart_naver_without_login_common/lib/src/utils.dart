import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'dart_naver_without_login_common.dart';

enum RequestMethod { get, post, put, delete }

enum ApiAuthType { naverDevelopers, naverCloud }

class NaverApiException implements Exception {
  const NaverApiException(this.statusCode, this.body);

  final int statusCode;
  final String body;

  @override
  String toString() => 'NaverApiException($statusCode): $body';
}

/// HTTP helpers shared by the NAVER API packages.
class ApiUtil {
  ApiUtil._();

  /// Sends a JSON or form-encoded API request and parses its JSON response.
  static Future<T> requestApiWithoutLogin<T>(
    String url,
    T Function(Map<String, dynamic> json) parse, {
    RequestMethod requestMethod = RequestMethod.get,
    ApiAuthType authType = ApiAuthType.naverDevelopers,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    http.Client? client,
  }) async {
    final requestHeaders = _authenticatedHeaders(headers, authType);
    requestHeaders.putIfAbsent(
      'Content-Type',
      () => 'application/json; charset=UTF-8',
    );
    final requestBody = _encodeBody(body, requestHeaders['Content-Type']);
    final requestClient = client ?? http.Client();

    try {
      final uri = Uri.parse(url);
      final response = await switch (requestMethod) {
        RequestMethod.get => requestClient.get(uri, headers: requestHeaders),
        RequestMethod.post => requestClient.post(
          uri,
          headers: requestHeaders,
          body: requestBody,
          encoding: utf8,
        ),
        RequestMethod.put => requestClient.put(
          uri,
          headers: requestHeaders,
          body: requestBody,
          encoding: utf8,
        ),
        RequestMethod.delete => requestClient.delete(
          uri,
          headers: requestHeaders,
          body: requestBody,
          encoding: utf8,
        ),
      };

      return _parseResponse(response, parse);
    } finally {
      if (client == null) {
        requestClient.close();
      }
    }
  }

  /// Sends a multipart image request and parses its JSON response.
  static Future<T> requestMultipartApi<T>(
    String url,
    Uint8List image,
    T Function(Map<String, dynamic> json) parse, {
    ApiAuthType authType = ApiAuthType.naverDevelopers,
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    final requestHeaders = _authenticatedHeaders(headers, authType);
    final requestClient = client ?? http.Client();

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(requestHeaders);
      request.files.add(http.MultipartFile.fromBytes('image', image));
      final streamedResponse = await requestClient.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      return _parseResponse(response, parse);
    } finally {
      if (client == null) {
        requestClient.close();
      }
    }
  }

  static Map<String, String> _authenticatedHeaders(
    Map<String, String>? headers,
    ApiAuthType authType,
  ) {
    final result = <String, String>{...?headers};
    final (idHeader, secretHeader, clientId, clientSecret) = switch (authType) {
      ApiAuthType.naverDevelopers => (
        'X-Naver-Client-Id',
        'X-Naver-Client-Secret',
        NaverWithoutLoginApi.clientId,
        NaverWithoutLoginApi.clientSecret,
      ),
      ApiAuthType.naverCloud => (
        'X-NCP-APIGW-API-KEY-ID',
        'X-NCP-APIGW-API-KEY',
        NaverCloudApi.clientId,
        NaverCloudApi.clientSecret,
      ),
    };

    if ((!result.containsKey(idHeader) && clientId == null) ||
        (!result.containsKey(secretHeader) && clientSecret == null)) {
      throw StateError('Client ID and client secret must be initialized.');
    }

    if (clientId != null) {
      result.putIfAbsent(idHeader, () => clientId);
    }
    if (clientSecret != null) {
      result.putIfAbsent(secretHeader, () => clientSecret);
    }
    return result;
  }

  static Object? _encodeBody(Map<String, dynamic>? body, String? contentType) {
    if (body == null) {
      return null;
    }
    if (contentType?.toLowerCase().startsWith('application/json') ?? false) {
      return jsonEncode(body);
    }
    return body.map((key, value) => MapEntry(key, value.toString()));
  }

  static T _parseResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic> json) parse,
  ) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw NaverApiException(
        response.statusCode,
        utf8.decode(response.bodyBytes, allowMalformed: true),
      );
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map) {
      throw const FormatException('Expected a JSON object response.');
    }
    return parse(Map<String, dynamic>.from(decoded));
  }
}
