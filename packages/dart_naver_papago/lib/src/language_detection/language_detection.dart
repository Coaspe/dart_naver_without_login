import 'package:dart_naver_papago/dart_naver_papago.dart';

class LanguageDetection {
  /// Detects the language of the given [text] using the Naver Papago API.
  ///
  /// The [text] parameter represents the text for which the language needs to be detected.
  /// The [headers] parameter is an optional map of additional headers to be included in the API request.
  ///
  /// Returns a [Future] that completes with a [LanguageDetectionResponse] object containing the detected language.
  ///
  /// Example usage:
  /// ```dart
  /// String text = "Hello, how are you?";
  /// LanguageDetectionResponse response = await LanguageDetection.detectLanguage(text);
  /// print(response.language);
  /// ```
  static Future<LanguageDetectionResponse> detectLanguage(String text,
      {Map<String, String>? headers}) async {
    final body = <String, String>{"query": text};
    final message = await ApiUtil.requestApiWithoutLogin(
        ServerHost.languageDetection, LanguageDetectionResponse.fromJson,
        requestMethod: RequestMethod.post, headers: headers, body: body);
    return message;
  }
}
