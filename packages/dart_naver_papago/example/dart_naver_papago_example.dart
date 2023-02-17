import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';

void main() async {
  NaverWithoutLoginApi.init(clientId: "", clientSecret: "");
  Map<String, String> headers = {};
  headers["X-Naver-Client-Id"] = "";
  headers["X-Naver-Client-Secret"] = "";
  try {
    var result = await http.get(
      Uri.parse(
          '${ServerHost.romanization}?query=${Uri.encodeComponent("이상혁")}'),
      headers: headers,
    );
    print(result.statusCode);
    var x = jsonDecode(result.body);
  } catch (e) {
    print(e);
  }
}
