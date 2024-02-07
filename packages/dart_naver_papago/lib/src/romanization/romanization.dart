import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';

import 'model/romanization_response.dart';

class Romanization {
  /// Transliterates the given [text] into Romanized form.
  ///
  /// The [text] parameter represents the text to be transliterated.
  /// The [headers] parameter is an optional map of HTTP headers to be included in the request.
  ///
  /// Returns a [Future] that completes with a [RomanizationResponse] object containing the Romanized text.
  ///
  /// Example usage:
  /// ```dart
  /// final response = await romanization('안녕하세요');
  /// print(response.romanizedText);
  /// ```
  static Future<RomanizationResponse> romanization(String text,
      {Map<String, String>? headers}) async {
    final url = '${ServerHost.romanization}?query=${Uri.encodeComponent(text)}';
    final romanization = await ApiUtil.requestApiWithoutLogin(
        url, RomanizationResponse.fromJson,
        requestMethod: RequestMethod.get, headers: headers);
    return romanization;
  }
}
