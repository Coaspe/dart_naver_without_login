# dart_naver_without_login_common

Shared authentication and HTTP utilities for the unofficial
`dart_naver_papago` and `dart_naver_clova_face_recognition` packages.

Use `NaverWithoutLoginApi` for APIs registered through NAVER Developers:

```dart
NaverWithoutLoginApi.init(
  clientId: developersClientId,
  clientSecret: developersClientSecret,
);
```

Use `NaverCloudApi` for APIs registered through NAVER Cloud Platform:

```dart
NaverCloudApi.init(
  clientId: cloudClientId,
  clientSecret: cloudClientSecret,
);
```

Applications normally depend on one of the feature packages instead of using
this package directly.
