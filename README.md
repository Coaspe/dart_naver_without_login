# Dart NAVER APIs without login

[![Dart](https://img.shields.io/badge/Dart-3.11%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![Pub Version](https://img.shields.io/pub/v/dart_naver_papago)](https://pub.dev/packages/dart_naver_papago)
[![Pub Points](https://img.shields.io/pub/points/dart_naver_papago)](https://pub.dev/packages/dart_naver_papago/score)
[![License: MIT](https://img.shields.io/github/license/Coaspe/dart_naver_without_login)](LICENSE)

Unofficial Dart clients for NAVER APIs that use application credentials instead
of NAVER Login.

This repository contains three packages:

- [`dart_naver_papago`](https://pub.dev/packages/dart_naver_papago): Papago text translation, language detection, and Korean-name romanization.
- [`dart_naver_clova_face_recognition`](https://pub.dev/packages/dart_naver_clova_face_recognition): celebrity and face recognition.
- [`dart_naver_without_login_common`](https://pub.dev/packages/dart_naver_without_login_common): shared authentication and HTTP utilities.

## Requirements

- Dart 3.11 or later.
- Application credentials for the API being called.

Papago translation and language detection moved from NAVER Developers to
[NAVER Cloud Platform](https://www.ncloud.com/product/aiService/papagoTranslation).
They require NAVER Cloud credentials:

```dart
NaverCloudApi.init(
  clientId: cloudClientId,
  clientSecret: cloudClientSecret,
);
```

Korean-name romanization and CLOVA Face Recognition still use
[NAVER Developers](https://developers.naver.com/main/) credentials:

```dart
NaverWithoutLoginApi.init(
  clientId: developersClientId,
  clientSecret: developersClientSecret,
);
```

Both credential sets can be initialized in the same process.

## Example

```dart
final translation = await PapagoTranslation.getTranslation(
  LangCode.ko,
  LangCode.en,
  '안녕하세요',
);
print(translation.getText);

final detected = await LanguageDetection.detectLanguage('안녕하세요');
print(detected.langCode);

final romanized = await Romanization.romanization('강형욱');
print(romanized.aResult.first.aItems.first.name);
```

For face recognition:

```dart
final celebrity = await CelebrityRecognition.recognizeCelebrity(imageBytes);
final face = await FaceRecognition.recognizeFace(imageBytes);
```

These packages are not endorsed by NAVER and do not represent NAVER or anyone
involved in managing NAVER products.

## Development

The repository uses a Dart pub workspace.

```sh
make get
make generate
make check
make publish-dry-run
```
