import 'dart:convert';

import 'package:dart_naver_datalab/dart_naver_datalab.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    NaverWithoutLoginApi.init(clientId: 'id', clientSecret: 'secret');
  });

  test('declares all 9 current DataLab operations', () {
    expect(DatalabEndpoint.values, hasLength(9));
  });

  test('calls all eight Shopping Insight operations', () async {
    final paths = <String>{};
    final client = MockClient((request) async {
      paths.add(request.url.path);
      return http.Response(
        '{"startDate":"","endDate":"","timeUnit":"month","results":[]}',
        200,
      );
    });
    final arguments = (
      startDate: DateTime(2026, 1),
      endDate: DateTime(2026, 2),
      timeUnit: TrendTimeUnit.month,
    );

    await DatalabApi.shoppingCategories(
      startDate: arguments.startDate,
      endDate: arguments.endDate,
      timeUnit: arguments.timeUnit,
      categories: [
        ShoppingCategoryGroup(name: '패션', categoryCodes: ['50000000']),
      ],
      client: client,
    );
    await DatalabApi.shoppingCategoryByDevice(
      startDate: arguments.startDate,
      endDate: arguments.endDate,
      timeUnit: arguments.timeUnit,
      category: '50000000',
      client: client,
    );
    await DatalabApi.shoppingCategoryByGender(
      startDate: arguments.startDate,
      endDate: arguments.endDate,
      timeUnit: arguments.timeUnit,
      category: '50000000',
      client: client,
    );
    await DatalabApi.shoppingCategoryByAge(
      startDate: arguments.startDate,
      endDate: arguments.endDate,
      timeUnit: arguments.timeUnit,
      category: '50000000',
      client: client,
    );
    await DatalabApi.shoppingKeywords(
      startDate: arguments.startDate,
      endDate: arguments.endDate,
      timeUnit: arguments.timeUnit,
      category: '50000000',
      keywords: [ShoppingKeywordGroup(name: '정장', keyword: '정장')],
      client: client,
    );
    await DatalabApi.shoppingKeywordByDevice(
      startDate: arguments.startDate,
      endDate: arguments.endDate,
      timeUnit: arguments.timeUnit,
      category: '50000000',
      keyword: '정장',
      client: client,
    );
    await DatalabApi.shoppingKeywordByGender(
      startDate: arguments.startDate,
      endDate: arguments.endDate,
      timeUnit: arguments.timeUnit,
      category: '50000000',
      keyword: '정장',
      client: client,
    );
    await DatalabApi.shoppingKeywordByAge(
      startDate: arguments.startDate,
      endDate: arguments.endDate,
      timeUnit: arguments.timeUnit,
      category: '50000000',
      keyword: '정장',
      client: client,
    );

    expect(
      paths,
      DatalabEndpoint.values
          .where((endpoint) => endpoint != DatalabEndpoint.search)
          .map((endpoint) => endpoint.path)
          .toSet(),
    );
  });

  test('requests integrated search trends', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/v1/datalab/search');
      expect(request.method, 'POST');
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['startDate'], '2026-01-01');
      expect(body['keywordGroups'], [
        {
          'groupName': 'Dart',
          'keywords': ['dart', 'flutter'],
        },
      ]);
      return http.Response(
        '{"startDate":"2026-01-01","endDate":"2026-01-31",'
        '"timeUnit":"date","results":[{"title":"Dart",'
        '"keywords":["dart"],"data":[{"period":"2026-01-01",'
        '"ratio":100}]}]}',
        200,
      );
    });

    final response = await DatalabApi.searchTrends(
      startDate: DateTime(2026),
      endDate: DateTime(2026, 1, 31),
      timeUnit: TrendTimeUnit.date,
      keywordGroups: [
        SearchKeywordGroup(name: 'Dart', keywords: ['dart', 'flutter']),
      ],
      client: client,
    );

    expect(response.results.single.data.single.ratio, 100);
  });

  test('requests shopping keyword age breakdown', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/v1/datalab/shopping/category/keyword/age');
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['category'], '50000000');
      expect(body['keyword'], '정장');
      return http.Response(
        '{"startDate":"","endDate":"","timeUnit":"month","results":[]}',
        200,
      );
    });

    await DatalabApi.shoppingKeywordByAge(
      startDate: DateTime(2026, 1),
      endDate: DateTime(2026, 2),
      timeUnit: TrendTimeUnit.month,
      category: '50000000',
      keyword: '정장',
      client: client,
    );
  });
}
