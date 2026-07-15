import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'dart_naver_without_login_common.dart';

enum RequestMethod { get, post, put, patch, delete }

enum ApiAuthType { none, naverDevelopers, naverCloud, naverCloudIam }

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

  /// Parses an already buffered successful response as a JSON object.
  static T parseJsonResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic> json) parse,
  ) => _parseResponse(response, parse);

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
    final response = await requestRaw(
      url,
      requestMethod: requestMethod,
      authType: authType,
      headers: headers,
      body: body,
      client: client,
    );
    return _parseResponse(response, parse);
  }

  /// Sends an API request and returns the complete buffered response.
  static Future<http.Response> requestRaw(
    String url, {
    RequestMethod requestMethod = RequestMethod.get,
    ApiAuthType authType = ApiAuthType.naverDevelopers,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    http.Client? client,
  }) async {
    final uri = Uri.parse(url);
    final requestHeaders = _authenticatedHeaders(
      uri,
      requestMethod,
      headers,
      authType,
    );
    requestHeaders.putIfAbsent(
      'Content-Type',
      () => 'application/json; charset=UTF-8',
    );
    final requestBody = _encodeBody(body, requestHeaders['Content-Type']);
    final requestClient = client ?? http.Client();

    try {
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
        RequestMethod.patch => requestClient.patch(
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
      _throwForError(response);
      return response;
    } finally {
      if (client == null) {
        requestClient.close();
      }
    }
  }

  /// Sends an API request and returns its response bytes.
  static Future<Uint8List> requestBytes(
    String url, {
    RequestMethod requestMethod = RequestMethod.get,
    ApiAuthType authType = ApiAuthType.naverDevelopers,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    http.Client? client,
  }) async {
    final response = await requestRaw(
      url,
      requestMethod: requestMethod,
      authType: authType,
      headers: headers,
      body: body,
      client: client,
    );
    return response.bodyBytes;
  }

  /// Sends an API request and decodes its response as UTF-8 text.
  static Future<String> requestText(
    String url, {
    RequestMethod requestMethod = RequestMethod.get,
    ApiAuthType authType = ApiAuthType.naverDevelopers,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    http.Client? client,
  }) async {
    final bytes = await requestBytes(
      url,
      requestMethod: requestMethod,
      authType: authType,
      headers: headers,
      body: body,
      client: client,
    );
    return utf8.decode(bytes);
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
    final response = await requestMultipart(
      url,
      files: [http.MultipartFile.fromBytes('image', image)],
      authType: authType,
      headers: headers,
      client: client,
    );
    return _parseResponse(response, parse);
  }

  /// Sends a multipart request with arbitrary fields and files.
  static Future<http.Response> requestMultipart(
    String url, {
    RequestMethod requestMethod = RequestMethod.post,
    ApiAuthType authType = ApiAuthType.naverDevelopers,
    Map<String, String>? headers,
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
    http.Client? client,
  }) async {
    final uri = Uri.parse(url);
    final requestHeaders = _authenticatedHeaders(
      uri,
      requestMethod,
      headers,
      authType,
    )..removeWhere((key, _) => key.toLowerCase() == 'content-type');
    final requestClient = client ?? http.Client();

    try {
      final request = http.MultipartRequest(
        requestMethod.name.toUpperCase(),
        uri,
      );
      request.headers.addAll(requestHeaders);
      request.fields.addAll(fields ?? const {});
      request.files.addAll(files ?? const []);
      final streamedResponse = await requestClient.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      _throwForError(response);
      return response;
    } finally {
      if (client == null) {
        requestClient.close();
      }
    }
  }

  static Map<String, String> _authenticatedHeaders(
    Uri uri,
    RequestMethod requestMethod,
    Map<String, String>? headers,
    ApiAuthType authType,
  ) {
    final result = <String, String>{...?headers};
    if (authType == ApiAuthType.none) {
      return result;
    }
    if (authType == ApiAuthType.naverCloudIam) {
      const timestampHeader = 'x-ncp-apigw-timestamp';
      const accessKeyHeader = 'x-ncp-iam-access-key';
      const signatureHeader = 'x-ncp-apigw-signature-v2';
      if (result.containsKey(timestampHeader) &&
          result.containsKey(accessKeyHeader) &&
          result.containsKey(signatureHeader)) {
        return result;
      }

      final timestamp =
          result[timestampHeader] ??
          DateTime.now().millisecondsSinceEpoch.toString();
      final accessKey = NaverCloudIamApi.accessKey;
      if (accessKey == null) {
        throw StateError('NAVER Cloud IAM credentials must be initialized.');
      }
      result[timestampHeader] = timestamp;
      result[accessKeyHeader] = accessKey;
      result[signatureHeader] = NaverCloudIamApi.createSignature(
        method: requestMethod.name,
        uri: uri,
        timestamp: timestamp,
      );
      return result;
    }

    final (idHeader, secretHeader, clientId, clientSecret) = switch (authType) {
      ApiAuthType.none || ApiAuthType.naverCloudIam => throw StateError(
        'Authentication type is handled separately.',
      ),
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
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map) {
      throw const FormatException('Expected a JSON object response.');
    }
    return parse(Map<String, dynamic>.from(decoded));
  }

  static void _throwForError(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw NaverApiException(
        response.statusCode,
        utf8.decode(response.bodyBytes, allowMalformed: true),
      );
    }
  }
}
