enum NaverRecognition {
  voice('voicerecg', 1),
  music('music', 1),
  qrCode('qrcode', 1),
  japanese('japanese', 1),
  wineLabel('wine', 1),
  hanjaHandwriting('hanja', 2);

  const NaverRecognition(this.apiValue, this.version);
  final String apiValue;
  final int version;
}

enum NaverInAppTarget {
  newWindow('new'),
  replace('replace'),
  current('inpage');

  const NaverInAppTarget(this.apiValue);
  final String apiValue;
}

class NaverApp {
  NaverApp._();

  static Uri launch({bool android = false}) =>
      scheme('default', version: android ? 5 : 1);

  static Uri recognition(NaverRecognition recognition) => scheme(
    'search',
    parameters: {'qmenu': recognition.apiValue},
    version: recognition.version,
  );

  static Uri inAppBrowser(
    Uri url, {
    NaverInAppTarget target = NaverInAppTarget.newWindow,
  }) {
    _validateHttpUri(url);
    return scheme(
      'inappbrowser',
      parameters: {'url': url.toString(), 'target': target.apiValue},
      version: 6,
    );
  }

  static Uri addShortcut({
    required Uri url,
    required Uri icon,
    required String title,
    required String serviceCode,
  }) {
    _validateHttpUri(url);
    _validateHttpUri(icon);
    if (title.isEmpty || serviceCode.isEmpty) {
      throw ArgumentError('Title and service code must not be empty.');
    }
    return scheme(
      'addshortcut',
      parameters: {
        'url': url.toString(),
        'icon': icon.toString(),
        'title': title,
        'serviceCode': serviceCode,
      },
      version: 7,
    );
  }

  static Uri scheme(
    String command, {
    Map<String, String> parameters = const {},
    required int version,
  }) {
    if (command.isEmpty || version < 1) {
      throw ArgumentError('Command and a positive version are required.');
    }
    return Uri(
      scheme: 'naversearchapp',
      host: command,
      queryParameters: {...parameters, 'version': '$version'},
    );
  }

  static Uri relay(
    String command, {
    Map<String, String> parameters = const {},
    required int version,
  }) {
    if (command.isEmpty || version < 1) {
      throw ArgumentError('Command and a positive version are required.');
    }
    return Uri.http('naverapp.naver.com', '/$command/', {
      ...parameters,
      'version': '$version',
    });
  }

  static String androidIntent(
    String command, {
    Map<String, String> parameters = const {},
    required int version,
  }) {
    final query = Uri(
      queryParameters: {...parameters, 'version': '$version'},
    ).query;
    return 'intent://$command?$query#Intent;'
        'scheme=naversearchapp;'
        'action=android.intent.action.VIEW;'
        'category=android.intent.category.BROWSABLE;'
        'package=com.nhn.android.search;end';
  }

  static void _validateHttpUri(Uri uri) {
    if (!uri.hasAuthority || (uri.scheme != 'http' && uri.scheme != 'https')) {
      throw ArgumentError.value(
        uri,
        'url',
        'URL must be an absolute HTTP URL.',
      );
    }
  }
}
