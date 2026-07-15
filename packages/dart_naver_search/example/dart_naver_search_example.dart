import 'package:dart_naver_search/dart_naver_search.dart';

Future<void> main() async {
  NaverWithoutLoginApi.init(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
  );
  final result = await SearchApi.news('네이버');
  print(result.items.first.title);
}
