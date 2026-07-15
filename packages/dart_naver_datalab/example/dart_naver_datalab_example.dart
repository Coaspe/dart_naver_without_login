import 'package:dart_naver_datalab/dart_naver_datalab.dart';

Future<void> main() async {
  NaverWithoutLoginApi.init(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
  );
  final result = await DatalabApi.searchTrends(
    startDate: DateTime(2026, 1, 1),
    endDate: DateTime(2026, 1, 31),
    timeUnit: TrendTimeUnit.month,
    keywordGroups: [
      SearchKeywordGroup(name: 'Dart', keywords: ['dart']),
    ],
  );
  print(result.results.first.title);
}
