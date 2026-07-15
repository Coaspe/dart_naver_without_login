import 'package:dart_naver_papago/src/papago_translation/model/papago_response_message.dart';
import 'package:dart_naver_papago/src/service.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'package:http/http.dart' as http;

import 'model/papago_response.dart';

class PapagoTranslation {
  /// Translates the given [text] from the source language [src] to the target language [tar].
  ///
  /// The [headers] parameter is an optional map of additional headers to be included in the API request.
  ///
  /// Throws an [ArgumentError] if the language pair or text is invalid.
  ///
  /// Returns a [Future] that completes with a [PapagoResponseMessage] containing the translated text.
  static Future<PapagoResponseMessage> getTranslation(
    LangCode src,
    LangCode tar,
    String text, {
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    if (!checkTranslatable(src, tar)) {
      throw ArgumentError(
        '${src.valueToString} -> ${tar.valueToString} is not supported.',
      );
    }
    if (text.isEmpty || text.runes.length > 5000) {
      throw ArgumentError.value(
        text,
        'text',
        'Text must contain between 1 and 5000 characters.',
      );
    }

    final body = <String, dynamic>{
      'source': src.valueToString,
      'target': tar.valueToString,
      'text': text,
    };
    final message = await ApiUtil.requestApiWithoutLogin(
      ServerHost.papagoTranslation,
      PapagoResponse.fromJson,
      requestMethod: RequestMethod.post,
      authType: ApiAuthType.naverCloud,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        ...?headers,
      },
      body: body,
      client: client,
    );

    return message.message;
  }

  /// Check whether Papago supports [src] to [tar] translation.
  static bool checkTranslatable(LangCode src, LangCode tar) =>
      possibleSrcToTar.containsKey(src) && possibleSrcToTar[src]!.contains(tar);
}
