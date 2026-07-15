import 'package:dart_naver_web_tools/dart_naver_web_tools.dart';
import 'package:test/test.dart';

void main() {
  test('builds an encoded NAVER share URI', () {
    final uri = NaverShare.uri(
      Uri.parse('https://example.com/path?a=1&b=2'),
      title: '제목',
    );

    expect(uri.host, 'share.naver.com');
    expect(uri.queryParameters['url'], 'https://example.com/path?a=1&b=2');
    expect(uri.queryParameters['title'], '제목');
  });

  test('escapes script-breaking characters in share-button titles', () {
    final markup = NaverShare.buttonMarkup(title: '</script>');

    expect(markup, contains(r'\u003c/script>'));
    expect(markup, isNot(contains('"</script>"')));
  });

  test('generates official Open Main markup', () {
    final markup = NaverOpenMain.markup(
      title: '뉴스',
      url: Uri.parse('https://example.com'),
    );

    expect(markup, contains('class="nv-openmain"'));
    expect(markup, contains('data-type="W2"'));
    expect(markup, contains('https://openmain.pstatic.net/js/openmain.js'));
  });

  test('recognizes Open Main page requests', () {
    expect(
      NaverOpenMain.isOpenMainRequest(
        Uri.parse('https://example.com?napp=mysection'),
      ),
      isTrue,
    );
  });

  test('builds every documented NAVER app link form', () {
    final recognition = NaverApp.recognition(NaverRecognition.hanjaHandwriting);
    expect(recognition.toString(), contains('qmenu=hanja'));
    expect(recognition.queryParameters['version'], '2');

    final browser = NaverApp.inAppBrowser(Uri.parse('https://example.com'));
    expect(browser.host, 'inappbrowser');

    final relay = NaverApp.relay(
      'search',
      parameters: {'qmenu': 'voicerecg'},
      version: 1,
    );
    expect(relay.host, 'naverapp.naver.com');

    final intent = NaverApp.androidIntent(
      'search',
      parameters: {'qmenu': 'voicerecg'},
      version: 1,
    );
    expect(intent, contains('package=com.nhn.android.search'));
  });
}
