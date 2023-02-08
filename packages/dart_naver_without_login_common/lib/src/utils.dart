import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart_naver_without_login_common.dart';

enum RequestMethod { get, post, put, delete }

class ApiUtil {
  static Future<T> requestApiWithoutLogin<T, G>(
      String url, Function(G json) task,
      {RequestMethod requestMethod = RequestMethod.get,
      Map<String, String>? headers,
      Map<String, String>? body}) async {
    assert(
        NaverWithoutLoginApi.clientId != null &&
            NaverWithoutLoginApi.clientSecret != null,
        "Client id and client secrete must not be null.");

    headers ??= {};
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    headers["X-Naver-Client-Id"] = NaverWithoutLoginApi.clientId!;
    headers["X-Naver-Client-Secret"] = NaverWithoutLoginApi.clientSecret!;

    try {
      http.Response response;
      // Api request method
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
    } catch (e) {
      rethrow;
    }
  }
}
