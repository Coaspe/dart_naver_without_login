# dart_naver_datalab

An unofficial Dart client for all nine DataLab operations in NAVER's current
non-login API catalog: integrated search trends plus every Shopping Insight
category and keyword trend breakdown.

```dart
NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret);

final trends = await DatalabApi.searchTrends(
  startDate: DateTime(2026, 1, 1),
  endDate: DateTime(2026, 1, 31),
  timeUnit: TrendTimeUnit.date,
  keywordGroups: [
    SearchKeywordGroup(name: 'Dart', keywords: ['dart', 'flutter']),
  ],
);
```

See the [official DataLab documentation](https://developers.naver.com/docs/serviceapi/datalab/).
The package is not endorsed by NAVER.
