# dart_naver_clova_face_recognition

An unofficial Dart client for NAVER CLOVA celebrity and face recognition.

## Requirements

- Dart 3.11 or later.
- An application with CLOVA Face Recognition enabled at
  [NAVER Developers](https://developers.naver.com/main/).
- Images no larger than 2MB.

## Usage

```dart
NaverWithoutLoginApi.init(
  clientId: developersClientId,
  clientSecret: developersClientSecret,
);

final celebrity = await CelebrityRecognition.recognizeCelebrity(imageBytes);
print(celebrity.faces.first.celebrity.value);

final face = await FaceRecognition.recognizeFace(imageBytes);
print(face.faces.first.emotion.value);
```

The package is not endorsed by NAVER.
