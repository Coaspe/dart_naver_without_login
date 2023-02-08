import 'package:dart_naver_papago/src/constants.dart';
import 'package:dart_naver_papago/src/language_detection/model/language_detection_response.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';

class LanguageDetection {
  static Future<LanguageDetectionResponse> detectLanguage(String text,
      {Map<String, String>? headers}) async {
    final body = <String, String>{"query": text};
    final message = await ApiUtil.requestApiWithoutLogin(
        ServerHost.languageDetection, LanguageDetectionResponse.fromJson,
        requestMethod: RequestMethod.post, headers: headers, body: body);
    return message;
  }
}
