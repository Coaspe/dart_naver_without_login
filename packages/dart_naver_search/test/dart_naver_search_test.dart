import 'dart:convert';

import 'package:dart_naver_search/dart_naver_search.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    NaverWithoutLoginApi.init(clientId: 'id', clientSecret: 'secret');
  });

  test('declares all 13 current search endpoints', () {
    expect(SearchEndpoint.values, hasLength(13));
  });

  test('calls every paginated search endpoint', () async {
    final paths = <String>{};
    final client = MockClient((request) async {
      paths.add(request.url.path);
      return http.Response(
        '{"lastBuildDate":"","total":0,"start":1,"display":10,"items":[]}',
        200,
      );
    });

    await SearchApi.news('q', client: client);
    await SearchApi.encyclopedia('q', client: client);
    await SearchApi.blogs('q', client: client);
    await SearchApi.shopping('q', client: client);
    await SearchApi.webDocuments('q', client: client);
    await SearchApi.images('q', client: client);
    await SearchApi.documents('q', client: client);
    await SearchApi.knowledgeIn('q', client: client);
    await SearchApi.books('q', client: client);
    await SearchApi.cafeArticles('q', client: client);
    await SearchApi.local('q', client: client);

    expect(paths, {
      '/v1/search/news',
      '/v1/search/encyc',
      '/v1/search/blog',
      '/v1/search/shop',
      '/v1/search/webkr',
      '/v1/search/image',
      '/v1/search/doc',
      '/v1/search/kin',
      '/v1/search/book',
      '/v1/search/cafearticle',
      '/v1/search/local',
    });
  });

  test('searches news with official parameters', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/v1/search/news');
      expect(request.url.queryParameters, {
        'query': '네이버',
        'display': '5',
        'start': '2',
        'sort': 'date',
      });
      expect(request.headers['X-Naver-Client-Id'], 'id');
      return http.Response.bytes(
        utf8.encode(
          '{"lastBuildDate":"today","total":1,"start":2,"display":5,'
          '"items":[{"title":"제목","originallink":"origin",'
          '"link":"link","description":"설명","pubDate":"date"}]}',
        ),
        200,
      );
    });

    final response = await SearchApi.news(
      '네이버',
      display: 5,
      start: 2,
      sort: SearchSort.date,
      client: client,
    );

    expect(response.items.single.title, '제목');
  });

  test('supports current shopping filters', () async {
    final client = MockClient((request) async {
      expect(request.url.queryParameters['filter'], 'naverpay');
      expect(request.url.queryParameters['exclude'], 'used:cbshop');
      return http.Response(
        '{"lastBuildDate":"","total":0,"start":1,"display":10,"items":[]}',
        200,
      );
    });

    await SearchApi.shopping(
      '노트북',
      naverPayOnly: true,
      exclude: {ShoppingExclude.used, ShoppingExclude.crossBorder},
      client: client,
    );
  });

  test('parses adult and errata responses', () async {
    final client = MockClient((request) async {
      if (request.url.path.endsWith('/adult')) {
        return http.Response('{"adult":"1"}', 200);
      }
      return http.Response.bytes(utf8.encode('{"errata":"네이버"}'), 200);
    });

    expect((await SearchApi.adult('query', client: client)).isAdult, isTrue);
    expect(
      (await SearchApi.errata('spdlqj', client: client)).correctedQuery,
      '네이버',
    );
  });
}
