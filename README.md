# dart_naver_without_login_api
 A unofficial packages provide easy way to use Naver apis that do not require login in Dart language.

- Naver Papago api
    - Translation
    - Language detection
    - Romanization

Added more soon

## Requirements

Here is what you need to use the Dart SDK:

- Dart 2.19.0 or higher

## Exmaple

First, generate [Naver client id and client secret](https://developers.naver.com/main/).

Initialize `NaverWithoutLoginApi` with your api key.
```dart
NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret)
```
Use `APIname.queryFunction` form to call query function.

You can check [available api](https://developers.naver.com/docs/common/openapiguide/).

### Papago api

```dart
/// Translate Korean to English
///
/// Returns PapagoResponseMessage
final result = await PapagoTranslation.getTranslation(LangCode.ko, LangCode.en, "안녕하세요");
print(result.getText); // Print Hello

/// Detect language code
///
/// Returns LanguageDetectionResponse
final result = await LanguageDetection.detectLanguage("안녕하세요");
print(result.langCode); // Print LangCode.ko

/// Name romanization
///
/// Returns RomanizationResponse
final result = await Romanization.romanization("강형욱");
```

## pub.dev
- [dart_naver_without_login_common](https://pub.dev/packages/dart_naver_without_login_common)
- [dart_naver_papago](https://pub.dev/packages/dart_naver_papago)

Documentation comment will be added gradually 😀
