# dart_naver_captcha

An unofficial Dart client for every NAVER image and audio CAPTCHA operation:
key issuance, user-input verification, and JPEG/WAV challenge download.

```dart
NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret);

final key = await CaptchaApi.issueImageKey();
final jpeg = await CaptchaApi.challenge(CaptchaType.image, key: key.key);
```

See the [official image CAPTCHA](https://developers.naver.com/docs/utils/captcha/)
and [audio CAPTCHA](https://developers.naver.com/docs/utils/scaptcha/) documentation.
The package is not endorsed by NAVER.
