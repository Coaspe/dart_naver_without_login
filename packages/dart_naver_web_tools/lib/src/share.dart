import 'dart:convert';

enum NaverShareButtonType {
  large('a'),
  small('b'),
  regular('c'),
  wide('d'),
  vertical('e'),
  horizontal('f');

  const NaverShareButtonType(this.apiValue);
  final String apiValue;
}

class NaverShare {
  NaverShare._();

  /// Builds the official `share.naver.com/web/shareView` URI.
  static Uri uri(Uri url, {String? title}) {
    _validateHttpUri(url);
    return Uri.https('share.naver.com', '/web/shareView', {
      'url': url.toString(),
      if (title != null && title.isNotEmpty) 'title': title,
    });
  }

  /// Generates the official JavaScript share-button markup.
  static String buttonMarkup({
    NaverShareButtonType type = NaverShareButtonType.large,
    String? title,
  }) {
    final encodedTitle = title == null
        ? null
        : jsonEncode(title).replaceAll('<', r'\u003c');
    final titleOption = title == null || title.isEmpty
        ? ''
        : ', "title": $encodedTitle';
    return '<span>\n'
        '<script type="text/javascript" '
        'src="https://ssl.pstatic.net/share/js/naver_sharebutton.js"></script>\n'
        '<script type="text/javascript">\n'
        'new ShareNaver.makeButton({"type": "${type.apiValue}"$titleOption});\n'
        '</script>\n'
        '</span>';
  }

  static void _validateHttpUri(Uri uri) {
    if (!uri.hasScheme ||
        !uri.hasAuthority ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      throw ArgumentError.value(
        uri,
        'url',
        'URL must be an absolute HTTP URL.',
      );
    }
  }
}
