import 'package:dart_naver_web_tools/dart_naver_web_tools.dart';

void main() {
  print(
    NaverShare.uri(Uri.parse('https://example.com/article'), title: 'Article'),
  );
  print(NaverOpenMain.markup(title: '뉴스'));
}
