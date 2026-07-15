import 'dart:io';

import 'package:dart_naver_papago/dart_naver_papago.dart';

Future<void> main() async {
  final clientId = Platform.environment['NAVER_CLOUD_CLIENT_ID'];
  final clientSecret = Platform.environment['NAVER_CLOUD_CLIENT_SECRET'];
  if (clientId == null || clientSecret == null) {
    stderr.writeln(
      'Set NAVER_CLOUD_CLIENT_ID and NAVER_CLOUD_CLIENT_SECRET first.',
    );
    exitCode = 64;
    return;
  }

  NaverCloudApi.init(clientId: clientId, clientSecret: clientSecret);
  final result = await PapagoTranslation.getTranslation(
    LangCode.ko,
    LangCode.en,
    '안녕하세요',
  );
  stdout.writeln(result.getText);
}
