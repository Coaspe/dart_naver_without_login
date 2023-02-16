import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart_naver_without_login_common.dart';

enum RequestMethod { get, post, put, delete }

class ApiUtil {
  /// Basic request method for API request
  ///
  /// [task] is a G.fromJson. Default Content Type is application/json.
  /// Now only POST and GET request supported.
  static Future<T> requestApiWithoutLogin<T, G>(
      String url, Function(G json) task,
      {RequestMethod requestMethod = RequestMethod.get,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    assert(
        NaverWithoutLoginApi.clientId != null &&
            NaverWithoutLoginApi.clientSecret != null,
        "Client id and client secrete must not be null.");

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
        // case RequestMethod.put:
        //   response = await http.put(Uri.parse(url), headers: headers);
        //   break;
        // case RequestMethod.delete:
        //   response = await http.delete(Uri.parse(url), headers: headers);
        //   break;
        default:
          response = await http.get(Uri.parse(url), headers: headers);
          break;
      }
      // Resopnse Status
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
  /// The size of [image] must be smaller than 2MB.
  static Future<T> requestMultipartApi<T, G>(
      String url, Uint8List image, Function(G json) task,
      {Map<String, String>? headers}) async {
    assert(
        NaverWithoutLoginApi.clientId != null &&
            NaverWithoutLoginApi.clientSecret != null,
        "Client id and client secrete must not be null.");

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

      // Resopnse Status
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
