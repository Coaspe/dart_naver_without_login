import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

enum SearchEndpoint {
  news('news'),
  encyclopedia('encyc'),
  blog('blog'),
  shopping('shop'),
  webDocuments('webkr'),
  images('image'),
  documents('doc'),
  knowledgeIn('kin'),
  books('book'),
  cafeArticles('cafearticle'),
  adult('adult'),
  errata('errata'),
  local('local');

  const SearchEndpoint(this.path);
  final String path;
}

enum SearchSort {
  similarity('sim'),
  date('date'),
  priceAscending('asc'),
  priceDescending('dsc'),
  point('point'),
  random('random'),
  comment('comment');

  const SearchSort(this.apiValue);
  final String apiValue;
}

enum ImageFilter {
  all('all'),
  large('large'),
  medium('medium'),
  small('small');

  const ImageFilter(this.apiValue);
  final String apiValue;
}

enum ShoppingExclude {
  used('used'),
  rental('rental'),
  crossBorder('cbshop');

  const ShoppingExclude(this.apiValue);
  final String apiValue;
}

class SearchApi {
  SearchApi._();

  static const _baseUrl = 'https://openapi.naver.com/v1/search';

  static Future<SearchResponse<NewsSearchItem>> news(
    String query, {
    int display = 10,
    int start = 1,
    SearchSort sort = SearchSort.similarity,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.news,
    query,
    NewsSearchItem.fromJson,
    display: display,
    start: start,
    sort: _checkedSort(sort, {SearchSort.similarity, SearchSort.date}),
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<EncyclopediaSearchItem>> encyclopedia(
    String query, {
    int display = 10,
    int start = 1,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.encyclopedia,
    query,
    EncyclopediaSearchItem.fromJson,
    display: display,
    start: start,
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<BlogSearchItem>> blogs(
    String query, {
    int display = 10,
    int start = 1,
    SearchSort sort = SearchSort.similarity,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.blog,
    query,
    BlogSearchItem.fromJson,
    display: display,
    start: start,
    sort: _checkedSort(sort, {SearchSort.similarity, SearchSort.date}),
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<ShoppingSearchItem>> shopping(
    String query, {
    int display = 10,
    int start = 1,
    SearchSort sort = SearchSort.similarity,
    bool naverPayOnly = false,
    Set<ShoppingExclude> exclude = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.shopping,
    query,
    ShoppingSearchItem.fromJson,
    display: display,
    start: start,
    sort: _checkedSort(sort, {
      SearchSort.similarity,
      SearchSort.date,
      SearchSort.priceAscending,
      SearchSort.priceDescending,
    }),
    extra: {
      if (naverPayOnly) 'filter': 'naverpay',
      if (exclude.isNotEmpty)
        'exclude': exclude.map((value) => value.apiValue).join(':'),
    },
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<TextSearchItem>> webDocuments(
    String query, {
    int display = 10,
    int start = 1,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.webDocuments,
    query,
    TextSearchItem.fromJson,
    display: display,
    start: start,
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<ImageSearchItem>> images(
    String query, {
    int display = 10,
    int start = 1,
    SearchSort sort = SearchSort.similarity,
    ImageFilter filter = ImageFilter.all,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.images,
    query,
    ImageSearchItem.fromJson,
    display: display,
    start: start,
    sort: _checkedSort(sort, {SearchSort.similarity, SearchSort.date}),
    extra: {'filter': filter.apiValue},
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<TextSearchItem>> documents(
    String query, {
    int display = 10,
    int start = 1,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.documents,
    query,
    TextSearchItem.fromJson,
    display: display,
    start: start,
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<TextSearchItem>> knowledgeIn(
    String query, {
    int display = 10,
    int start = 1,
    SearchSort sort = SearchSort.similarity,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.knowledgeIn,
    query,
    TextSearchItem.fromJson,
    display: display,
    start: start,
    sort: _checkedSort(sort, {
      SearchSort.similarity,
      SearchSort.date,
      SearchSort.point,
    }),
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<BookSearchItem>> books(
    String query, {
    int display = 10,
    int start = 1,
    SearchSort sort = SearchSort.similarity,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.books,
    query,
    BookSearchItem.fromJson,
    display: display,
    start: start,
    sort: _checkedSort(sort, {SearchSort.similarity, SearchSort.date}),
    headers: headers,
    client: client,
  );

  static Future<SearchResponse<CafeSearchItem>> cafeArticles(
    String query, {
    int display = 10,
    int start = 1,
    SearchSort sort = SearchSort.similarity,
    Map<String, String>? headers,
    http.Client? client,
  }) => _search(
    SearchEndpoint.cafeArticles,
    query,
    CafeSearchItem.fromJson,
    display: display,
    start: start,
    sort: _checkedSort(sort, {SearchSort.similarity, SearchSort.date}),
    headers: headers,
    client: client,
  );

  static Future<AdultSearchResponse> adult(
    String query, {
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateQuery(query);
    return ApiUtil.requestApiWithoutLogin(
      _uri(SearchEndpoint.adult, {'query': query}),
      AdultSearchResponse.fromJson,
      headers: headers,
      client: client,
    );
  }

  static Future<ErrataSearchResponse> errata(
    String query, {
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateQuery(query);
    return ApiUtil.requestApiWithoutLogin(
      _uri(SearchEndpoint.errata, {'query': query}),
      ErrataSearchResponse.fromJson,
      headers: headers,
      client: client,
    );
  }

  static Future<SearchResponse<LocalSearchItem>> local(
    String query, {
    int display = 1,
    int start = 1,
    SearchSort sort = SearchSort.random,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    if (display < 1 || display > 5) {
      throw RangeError.range(display, 1, 5, 'display');
    }
    if (start != 1) {
      throw RangeError.value(start, 'start', 'Local search only supports 1.');
    }
    return _search(
      SearchEndpoint.local,
      query,
      LocalSearchItem.fromJson,
      display: display,
      start: start,
      sort: _checkedSort(sort, {SearchSort.random, SearchSort.comment}),
      headers: headers,
      client: client,
      validatePagination: false,
    );
  }

  static Future<SearchResponse<T>> _search<T>(
    SearchEndpoint endpoint,
    String query,
    SearchItemParser<T> parseItem, {
    required int display,
    required int start,
    SearchSort? sort,
    Map<String, String> extra = const {},
    Map<String, String>? headers,
    http.Client? client,
    bool validatePagination = true,
  }) {
    _validateQuery(query);
    if (validatePagination) {
      _validatePagination(display, start);
    }
    final parameters = {
      'query': query,
      'display': '$display',
      'start': '$start',
      if (sort != null) 'sort': sort.apiValue,
      ...extra,
    };
    return ApiUtil.requestApiWithoutLogin(
      _uri(endpoint, parameters),
      (json) => SearchResponse.fromJson(json, parseItem),
      headers: headers,
      client: client,
    );
  }

  static String _uri(SearchEndpoint endpoint, Map<String, String> parameters) =>
      Uri.parse(
        '$_baseUrl/${endpoint.path}',
      ).replace(queryParameters: parameters).toString();

  static void _validateQuery(String query) {
    if (query.trim().isEmpty) {
      throw ArgumentError.value(query, 'query', 'Query must not be empty.');
    }
  }

  static void _validatePagination(int display, int start) {
    if (display < 1 || display > 100) {
      throw RangeError.range(display, 1, 100, 'display');
    }
    if (start < 1 || start > 1000) {
      throw RangeError.range(start, 1, 1000, 'start');
    }
  }

  static SearchSort _checkedSort(SearchSort sort, Set<SearchSort> supported) {
    if (!supported.contains(sort)) {
      throw ArgumentError.value(sort, 'sort', 'Unsupported sort for endpoint.');
    }
    return sort;
  }
}
