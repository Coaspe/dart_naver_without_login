# dart_naver_without_login_common

Shared authentication and HTTP utilities for the unofficial feature packages
in this workspace.

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

Use `NaverCloudIamApi` for NAVER Cloud management APIs that require an Access
Key, Secret Key, timestamp, and HMAC signature:

```dart
NaverCloudIamApi.init(accessKey: accessKey, secretKey: secretKey);
```

Applications normally depend on one of the feature packages instead of using
this package directly.
