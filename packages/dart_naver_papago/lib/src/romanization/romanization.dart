import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';

import 'model/romanization_response.dart';

class Romanization {
  /// Romanize given text.
  static Future<RomanizationResponse> romanization(String text,
      {Map<String, String>? headers}) async {
    final url = '${ServerHost.romanization}?query=${Uri.encodeComponent(text)}';
    final romanization = await ApiUtil.requestApiWithoutLogin(
        url, RomanizationResponse.fromJson,
        requestMethod: RequestMethod.get, headers: headers);
    return romanization;
  }
}
