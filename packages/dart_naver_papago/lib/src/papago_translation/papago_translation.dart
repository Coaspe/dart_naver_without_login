import 'package:dart_naver_papago/src/papago_translation/model/papago_response_message.dart';
import 'package:dart_naver_papago/src/service.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'model/papago_response.dart';

class PapagoTranslation {
  /// Get a champion mastery by player ID and champion ID
  ///
  /// text's language detection added soon.
  static Future<PapagoResponseMessage> getTranslation(
      LangCode src, LangCode tar, String text,
      {Map<String, String>? headers}) async {
    assert(checkTranslatable(src, tar),
        "${src.valueToString} can not be passed as src or ${src.valueToString} -> ${tar.valueToString} translation does not supported yet. \n Visite https://developers.naver.com/docs/papago/papago-nmt-overview.md");
    assert((await LanguageDetection.detectLanguage(text)).langCode == src,
        "text's language code must be same with src");

    final body = <String, String>{
      'source': src.valueToString,
      'target': tar.valueToString,
      'text': text
    };
    PapagoResponse message = await ApiUtil.requestApiWithoutLogin(
        ServerHost.papagoTranslation, PapagoResponse.fromJson,
        requestMethod: RequestMethod.post, headers: headers, body: body);

    return message.message;
  }

  static bool checkTranslatable(LangCode src, LangCode tar) =>
      possibleSrcToTar.containsKey(src) && possibleSrcToTar[src]!.contains(tar);
}
