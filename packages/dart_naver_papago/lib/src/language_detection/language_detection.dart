import 'package:dart_naver_papago/dart_naver_papago.dart';

class LanguageDetection {
  /// Detects language by given text
  static Future<LanguageDetectionResponse> detectLanguage(String text,
      {Map<String, String>? headers}) async {
    final body = <String, String>{"query": text};
    final message = await ApiUtil.requestApiWithoutLogin(
        ServerHost.languageDetection, LanguageDetectionResponse.fromJson,
        requestMethod: RequestMethod.post, headers: headers, body: body);
    return message;
  }
}
