import 'package:dart_naver_papago/src/model.dart';
import 'package:dart_naver_papago/src/service.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'package:test/test.dart';

void main() {
  var clientId = "your-id";
  var clientSecret = "your-secret";
  group('Romanization', () {
    setUp(() {
      NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret);
    });

    test('Get translation', () async {
      final result = await Romanization.romanization("강형욱");
      expect(result, isA<RomanizationResponse>());
    });
  });
  group('Papago translation test:', () {
    setUp(() {
      NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret);
    });

    test('Get translation', () async {
      final result = await PapagoTranslation.getTranslation(
          LangCode.ko, LangCode.en, "안녕하세요");
      print(result.getText);
      expect(result, isA<PapagoResponseMessage>());
    });

    test('Not supported src to trc assertion', () async {
      try {
        await PapagoTranslation.getTranslation(LangCode.en, LangCode.ru, ".");
      } catch (e) {
        print(e);
        expect(e, isA<AssertionError>());
      }
    });

    test('Different text language and src assertion', () async {
      try {
        await PapagoTranslation.getTranslation(LangCode.ru, LangCode.ko, ".");
      } catch (e) {
        print(e);
        expect(e, isA<AssertionError>());
      }
    });
  });
  group('Language detection', () {
    setUp(() {
      NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret);
    });
    test('Get Language code', () async {
      final result = await LanguageDetection.detectLanguage("안녕하세요.");
      print(result.langCode);
      expect(result, isA<LanguageDetectionResponse>());
    });
  });
}
