import 'package:dart_naver_papago/src/constants.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';

import 'model/romanization_response.dart';

class Romanization {
  static Future<RomanizationResponse> romanization(String text,
      {Map<String, String>? headers}) async {
    final url = '${ServerHost.romanization}?query=${Uri.encodeComponent(text)}';
    final romanization = await ApiUtil.requestApiWithoutLogin(
        url, RomanizationResponse.fromJson,
        requestMethod: RequestMethod.get, headers: headers);
    return romanization;
  }
}