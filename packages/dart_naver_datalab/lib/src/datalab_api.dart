import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

enum DatalabEndpoint {
  search('/v1/datalab/search'),
  shoppingCategories('/v1/datalab/shopping/categories'),
  shoppingCategoryDevice('/v1/datalab/shopping/category/device'),
  shoppingCategoryGender('/v1/datalab/shopping/category/gender'),
  shoppingCategoryAge('/v1/datalab/shopping/category/age'),
  shoppingKeywords('/v1/datalab/shopping/category/keywords'),
  shoppingKeywordDevice('/v1/datalab/shopping/category/keyword/device'),
  shoppingKeywordGender('/v1/datalab/shopping/category/keyword/gender'),
  shoppingKeywordAge('/v1/datalab/shopping/category/keyword/age');

  const DatalabEndpoint(this.path);
  final String path;
}

class DatalabApi {
  DatalabApi._();

  static const _baseUrl = 'https://openapi.naver.com';

  static Future<TrendResponse> searchTrends({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required List<SearchKeywordGroup> keywordGroups,
    TrendDevice? device,
    TrendGender? gender,
    Set<SearchTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) {
    if (keywordGroups.isEmpty || keywordGroups.length > 5) {
      throw RangeError.range(
        keywordGroups.length,
        1,
        5,
        'keywordGroups.length',
      );
    }
    return _request(
      DatalabEndpoint.search,
      {
        ..._period(startDate, endDate, timeUnit),
        'keywordGroups': keywordGroups.map((group) => group.toJson()).toList(),
        if (device != null) 'device': device.apiValue,
        if (gender != null) 'gender': gender.apiValue,
        if (ages.isNotEmpty)
          'ages': ages.map((age) => age.apiValue).toList(growable: false),
      },
      headers: headers,
      client: client,
    );
  }

  static Future<TrendResponse> shoppingCategories({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required List<ShoppingCategoryGroup> categories,
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) {
    if (categories.isEmpty || categories.length > 3) {
      throw RangeError.range(categories.length, 1, 3, 'categories.length');
    }
    return _request(
      DatalabEndpoint.shoppingCategories,
      {
        ..._shoppingBase(
          startDate,
          endDate,
          timeUnit,
          device: device,
          gender: gender,
          ages: ages,
        ),
        'category': categories.map((group) => group.toJson()).toList(),
      },
      headers: headers,
      client: client,
    );
  }

  static Future<TrendResponse> shoppingCategoryByDevice({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) => _shoppingCategoryBreakdown(
    DatalabEndpoint.shoppingCategoryDevice,
    startDate: startDate,
    endDate: endDate,
    timeUnit: timeUnit,
    category: category,
    device: device,
    gender: gender,
    ages: ages,
    headers: headers,
    client: client,
  );

  static Future<TrendResponse> shoppingCategoryByGender({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) => _shoppingCategoryBreakdown(
    DatalabEndpoint.shoppingCategoryGender,
    startDate: startDate,
    endDate: endDate,
    timeUnit: timeUnit,
    category: category,
    device: device,
    gender: gender,
    ages: ages,
    headers: headers,
    client: client,
  );

  static Future<TrendResponse> shoppingCategoryByAge({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) => _shoppingCategoryBreakdown(
    DatalabEndpoint.shoppingCategoryAge,
    startDate: startDate,
    endDate: endDate,
    timeUnit: timeUnit,
    category: category,
    device: device,
    gender: gender,
    ages: ages,
    headers: headers,
    client: client,
  );

  static Future<TrendResponse> shoppingKeywords({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    required List<ShoppingKeywordGroup> keywords,
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) {
    if (keywords.isEmpty || keywords.length > 5) {
      throw RangeError.range(keywords.length, 1, 5, 'keywords.length');
    }
    _validateValue(category, 'category');
    return _request(
      DatalabEndpoint.shoppingKeywords,
      {
        ..._shoppingBase(
          startDate,
          endDate,
          timeUnit,
          device: device,
          gender: gender,
          ages: ages,
        ),
        'category': category,
        'keyword': keywords.map((group) => group.toJson()).toList(),
      },
      headers: headers,
      client: client,
    );
  }

  static Future<TrendResponse> shoppingKeywordByDevice({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    required String keyword,
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) => _shoppingKeywordBreakdown(
    DatalabEndpoint.shoppingKeywordDevice,
    startDate: startDate,
    endDate: endDate,
    timeUnit: timeUnit,
    category: category,
    keyword: keyword,
    device: device,
    gender: gender,
    ages: ages,
    headers: headers,
    client: client,
  );

  static Future<TrendResponse> shoppingKeywordByGender({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    required String keyword,
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) => _shoppingKeywordBreakdown(
    DatalabEndpoint.shoppingKeywordGender,
    startDate: startDate,
    endDate: endDate,
    timeUnit: timeUnit,
    category: category,
    keyword: keyword,
    device: device,
    gender: gender,
    ages: ages,
    headers: headers,
    client: client,
  );

  static Future<TrendResponse> shoppingKeywordByAge({
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    required String keyword,
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
    Map<String, String>? headers,
    http.Client? client,
  }) => _shoppingKeywordBreakdown(
    DatalabEndpoint.shoppingKeywordAge,
    startDate: startDate,
    endDate: endDate,
    timeUnit: timeUnit,
    category: category,
    keyword: keyword,
    device: device,
    gender: gender,
    ages: ages,
    headers: headers,
    client: client,
  );

  static Future<TrendResponse> _shoppingCategoryBreakdown(
    DatalabEndpoint endpoint, {
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    required TrendDevice? device,
    required TrendGender? gender,
    required Set<ShoppingTrendAge> ages,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateValue(category, 'category');
    return _request(
      endpoint,
      {
        ..._shoppingBase(
          startDate,
          endDate,
          timeUnit,
          device: device,
          gender: gender,
          ages: ages,
        ),
        'category': category,
      },
      headers: headers,
      client: client,
    );
  }

  static Future<TrendResponse> _shoppingKeywordBreakdown(
    DatalabEndpoint endpoint, {
    required DateTime startDate,
    required DateTime endDate,
    required TrendTimeUnit timeUnit,
    required String category,
    required String keyword,
    required TrendDevice? device,
    required TrendGender? gender,
    required Set<ShoppingTrendAge> ages,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateValue(category, 'category');
    _validateValue(keyword, 'keyword');
    return _request(
      endpoint,
      {
        ..._shoppingBase(
          startDate,
          endDate,
          timeUnit,
          device: device,
          gender: gender,
          ages: ages,
        ),
        'category': category,
        'keyword': keyword,
      },
      headers: headers,
      client: client,
    );
  }

  static Future<TrendResponse> _request(
    DatalabEndpoint endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    http.Client? client,
  }) => ApiUtil.requestApiWithoutLogin(
    '$_baseUrl${endpoint.path}',
    TrendResponse.fromJson,
    requestMethod: RequestMethod.post,
    headers: {'Content-Type': 'application/json', ...?headers},
    body: body,
    client: client,
  );

  static Map<String, dynamic> _period(
    DateTime startDate,
    DateTime endDate,
    TrendTimeUnit timeUnit,
  ) {
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);
    if (start.isAfter(end)) {
      throw ArgumentError('startDate must not be after endDate.');
    }
    return {
      'startDate': _date(start),
      'endDate': _date(end),
      'timeUnit': timeUnit.apiValue,
    };
  }

  static Map<String, dynamic> _shoppingBase(
    DateTime startDate,
    DateTime endDate,
    TrendTimeUnit timeUnit, {
    TrendDevice? device,
    TrendGender? gender,
    Set<ShoppingTrendAge> ages = const {},
  }) => {
    ..._period(startDate, endDate, timeUnit),
    if (device != null) 'device': device.apiValue,
    if (gender != null) 'gender': gender.apiValue,
    if (ages.isNotEmpty)
      'ages': ages.map((age) => age.apiValue).toList(growable: false),
  };

  static String _date(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';

  static void _validateValue(String value, String name) {
    if (value.isEmpty) {
      throw ArgumentError.value(value, name, '$name must not be empty.');
    }
  }
}
