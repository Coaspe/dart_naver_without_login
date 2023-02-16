# dart_naver_clova_face_recognition
An unofficial package for using Naver Clova face recognition, celebrity recognition.

- Naver Clova face recognition API
    - Celebrity recognition
    - Face recognition

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

```dart
/// Recognize celebrity with given Uint8List image.
///
/// Returns CelebrityResponse
final result = await CelebrityRecognition.recognizeCelebrity(await io.File('your-image-path').readAsBytes())
print(result.runtimeType); // Print CelebrityResponse

/// Recognize face with given Uint8List image.
///
/// Returns FaceResponse.
final result = await FaceRecognition.recognizeFace(await io.File('your-image-path').readAsBytes());
print(result.runtimeType); // Print FaceResponse
```

## pub.dev
- [dart_naver_papago](https://pub.dev/packages/dart_naver_papago)
- [dart_naver_clova_face_recognition](https://pub.dev/packages/dart_naver_clova_face_recognition)
- [dart_naver_without_login_common](https://pub.dev/packages/dart_naver_without_login_common)

Documentation comment will be added gradually 😀
