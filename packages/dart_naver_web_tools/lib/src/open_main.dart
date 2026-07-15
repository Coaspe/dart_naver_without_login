import 'dart:convert';

enum OpenMainEnvironment {
  production('https://openmain.pstatic.net/js/openmain.js'),
  test('https://test-openmain.m.naver.com/js/openmain.js');

  const OpenMainEnvironment(this.scriptUrl);
  final String scriptUrl;
}

enum OpenMainButtonType {
  transparent('T1'),
  wide('W1'),
  compact('W2');

  const OpenMainButtonType(this.apiValue);
  final String apiValue;
}

class NaverOpenMain {
  NaverOpenMain._();

  static final _attributeEscape = HtmlEscape(HtmlEscapeMode.attribute);

  static String scriptTag({
    OpenMainEnvironment environment = OpenMainEnvironment.production,
  }) =>
      '<script type="text/javascript" src="${environment.scriptUrl}"></script>';

  static String buttonTag({
    String? title,
    Uri? url,
    OpenMainButtonType type = OpenMainButtonType.compact,
  }) {
    if (title != null && title.runes.length > 6) {
      throw ArgumentError.value(
        title,
        'title',
        'Title must not exceed 6 characters.',
      );
    }
    if (url != null &&
        (!url.hasScheme ||
            !url.hasAuthority ||
            (url.scheme != 'http' && url.scheme != 'https'))) {
      throw ArgumentError.value(
        url,
        'url',
        'URL must be an absolute HTTP URL.',
      );
    }

    final attributes = <String>[
      'class="nv-openmain"',
      'data-type="${type.apiValue}"',
      if (title != null && title.isNotEmpty)
        'data-title="${_attributeEscape.convert(title)}"',
      if (url != null) 'data-url="${_attributeEscape.convert(url.toString())}"',
    ];
    return '<div ${attributes.join(' ')}></div>';
  }

  static String markup({
    String? title,
    Uri? url,
    OpenMainButtonType type = OpenMainButtonType.compact,
    OpenMainEnvironment environment = OpenMainEnvironment.production,
  }) =>
      '${buttonTag(title: title, url: url, type: type)}\n'
      '${scriptTag(environment: environment)}';

  /// Whether NAVER loaded the page as an Open Main section.
  static bool isOpenMainRequest(Uri uri) =>
      uri.queryParameters['napp'] == 'mysection';
}
