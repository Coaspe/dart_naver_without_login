import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart_naver_without_login_common.dart';

enum RequestMethod { get, post, put, delete }

/// Singleton class for Restful API methods.
class ApiUtil {
  ApiUtil._();

  static final ApiUtil _instance = ApiUtil._();

  factory ApiUtil() => _instance;

  /// Basic request method for API request
  ///
  /// [url] - The URL of the API endpoint.
  /// [task] - A function that takes a generic type [G] as input and performs a task on the JSON response.
  /// [requestMethod] - The HTTP request method (GET or POST). Default is GET.
  /// [headers] - Optional headers to be included in the request.
  /// [body] - Optional request body data.
  ///
  /// Returns a Future of type [T] representing the result of the API request.
  static Future<T> requestApiWithoutLogin<T, G>(
      String url, Function(G json) task,
      {RequestMethod requestMethod = RequestMethod.get,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    assert(
        NaverWithoutLoginApi.clientId != null &&
            NaverWithoutLoginApi.clientSecret != null,
        "Client id and client secret must not be null.");

    headers ??= {};
    if (!headers.containsKey("Content-Type")) {
      headers['Content-Type'] = 'application/json; charset=UTF-8';
    }
    headers["X-Naver-Client-Id"] = NaverWithoutLoginApi.clientId!;
    headers["X-Naver-Client-Secret"] = NaverWithoutLoginApi.clientSecret!;

    try {
      http.Response response;
      // API request method
      switch (requestMethod) {
        case RequestMethod.get:
          response = await http.get(Uri.parse(url), headers: headers);
          break;
        case RequestMethod.post:
          response = await http.post(Uri.parse(url),
              headers: headers, body: jsonEncode(body));
          break;
        default:
          response = await http.get(Uri.parse(url), headers: headers);
          break;
      }
      // Response Status
      switch (response.statusCode) {
        case 200:
          return task(jsonDecode(response.body));
        default:
          throw Exception(
              "Status code :${response.statusCode}, ${response.body}");
      }
    } catch (_) {
      rethrow;
    }
  }

  /// Request multipart/form-data post using http.MultipartRequest.
  ///
  /// [url] - The URL of the API endpoint.
  /// [image] - The image data to be sent in the request.
  /// [task] - A function that takes a generic type [G] as input and performs a task on the JSON response.
  /// [headers] - Optional headers to be included in the request.
  ///
  /// Returns a Future of type [T] representing the result of the API request.
  ///
  /// Throws an exception if the request fails or the response status code is not 200.
  static Future<T> requestMultipartApi<T, G>(
      String url, Uint8List image, Function(G json) task,
      {Map<String, String>? headers}) async {
    assert(
        NaverWithoutLoginApi.clientId != null &&
            NaverWithoutLoginApi.clientSecret != null,
        "Client id and client secret must not be null.");

    headers ??= <String, String>{};
    headers["X-Naver-Client-Id"] = NaverWithoutLoginApi.clientId!;
    headers["X-Naver-Client-Secret"] = NaverWithoutLoginApi.clientSecret!;

    try {
      // Multipart request
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        image,
      ));
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);

      // Response Status
      switch (response.statusCode) {
        case 200:
          return task(jsonDecode(response.body));
        default:
          throw Exception(
              "Status code :${response.statusCode}, ${response.body}");
      }
    } catch (_) {
      rethrow;
    }
  }
}
