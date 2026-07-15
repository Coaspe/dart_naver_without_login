# dart_naver_web_tools

Pure Dart helpers for the web and app-integration entries in NAVER's current
service API catalog: NAVER Share, NAVER Open Main, and NAVER app URL schemes.

```dart
final shareUri = NaverShare.uri(
  Uri.parse('https://example.com/article'),
  title: 'Article',
);

final openMainMarkup = NaverOpenMain.markup(
  title: '뉴스',
  url: Uri.parse('https://example.com'),
);

final appLink = NaverApp.inAppBrowser(Uri.parse('https://example.com'));
```

See the official [NAVER Share](https://developers.naver.com/docs/share/navershare/)
and [Open Main](https://developers.naver.com/docs/openmain/) guides, plus the
[NAVER app URL scheme guide](https://developers.naver.com/docs/utils/mobileapp/).
The package is not endorsed by NAVER.
