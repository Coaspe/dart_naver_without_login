# dart_naver_without_login_api

<p align="center">
<img width="811" alt="스크린샷 2023-02-13 오후 6 06 30" src="https://user-images.githubusercontent.com/76432686/218416118-ac60bfbf-264d-4fce-9277-209dfcd8ecaf.png">
</p>


Unofficial packages provide easy way to use Naver APIs that do not require login written in Dart language.

These packages aren't endorsed by [Naver](https://naver.com) and don't reflect the views or opinions of Naver or anyone officially involved in producing or managing Naver properties.

- Naver Papago API
    - Translation
    - Language detection
    - Romanization

- Naver Clova face recognition API
    - Celebrity recognition
    - Face recognition

Added more soon

## Requirements

Here is what you need to use the Dart SDK:

- Dart 2.19.0 or higher

## Exmaple

First, generate [Naver client id and client secret](https://developers.naver.com/main/).

Initialize `NaverWithoutLoginApi` with your API key.
```dart
NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret)
```
Use `APIname.queryFunction` form to call query function.

You can check [available API](https://developers.naver.com/docs/common/openapiguide/).

### Papago API

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

### Clova face recognition API

```dart
/// Recognize celebrity with given Uint8List image.
///
/// Returns CelebrityResponse
final result = await CelebrityRecognition.recognizeCelebrity(await io.File('your-image-path').readAsBytes())
print(result.runtimeType); // Print CelebrityResponse

/// Recognize face with given Uint8List image.
///
/// Returns FaceResponse
final result = await FaceRecognition.recognizeFace(await io.File('your-image-path').readAsBytes());
print(result.runtimeType); // Print FaceResponse
```

## pub.dev
- [dart_naver_papago](https://pub.dev/packages/dart_naver_papago)
- [dart_naver_clova_face_recognition](https://pub.dev/packages/dart_naver_clova_face_recognition)
- [dart_naver_without_login_common](https://pub.dev/packages/dart_naver_without_login_common)

Documentation comment will be added gradually 😀
