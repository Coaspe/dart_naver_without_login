import 'package:dart_naver_captcha/dart_naver_captcha.dart';

Future<void> main() async {
  NaverWithoutLoginApi.init(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
  );
  final key = await CaptchaApi.issueImageKey();
  final image = await CaptchaApi.challenge(CaptchaType.image, key: key.key);
  print(image.length);
}
