# dart_naver_papago

An unofficial Dart client for NAVER Papago text translation, language detection,
and Korean-name romanization.

## Requirements

- Dart 3.11 or later.
- NAVER Cloud Platform credentials for Papago translation and language detection.
- NAVER Developers credentials for Korean-name romanization.

## Papago setup

Register an application for
[Papago Translation](https://www.ncloud.com/product/aiService/papagoTranslation),
then initialize its NAVER Cloud credentials:

```dart
NaverCloudApi.init(
  clientId: cloudClientId,
  clientSecret: cloudClientSecret,
);
```

Translate text or detect its language:

```dart
final translation = await PapagoTranslation.getTranslation(
  LangCode.ko,
  LangCode.en,
  '안녕하세요',
);
print(translation.getText);

final detected = await LanguageDetection.detectLanguage('안녕하세요');
print(detected.langCode);
```

Use `LangCode.auto` as the source language to let Papago detect it as part of a
translation request.

## Korean-name romanization setup

Register an application at [NAVER Developers](https://developers.naver.com/main/)
and initialize its credentials separately:

```dart
NaverWithoutLoginApi.init(
  clientId: developersClientId,
  clientSecret: developersClientSecret,
);

final response = await Romanization.romanization('강형욱');
print(response.aResult.first.aItems.first.name);
```

The package is not endorsed by NAVER.
