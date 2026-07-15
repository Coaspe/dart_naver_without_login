enum TrendTimeUnit {
  date('date'),
  week('week'),
  month('month');

  const TrendTimeUnit(this.apiValue);
  final String apiValue;
}

enum TrendDevice {
  pc('pc'),
  mobile('mo');

  const TrendDevice(this.apiValue);
  final String apiValue;
}

enum TrendGender {
  male('m'),
  female('f');

  const TrendGender(this.apiValue);
  final String apiValue;
}

enum SearchTrendAge {
  age0To12('1'),
  age13To18('2'),
  age19To24('3'),
  age25To29('4'),
  age30To34('5'),
  age35To39('6'),
  age40To44('7'),
  age45To49('8'),
  age50To54('9'),
  age55To59('10'),
  age60Plus('11');

  const SearchTrendAge(this.apiValue);
  final String apiValue;
}

enum ShoppingTrendAge {
  teens('10'),
  twenties('20'),
  thirties('30'),
  forties('40'),
  fifties('50'),
  sixtiesPlus('60');

  const ShoppingTrendAge(this.apiValue);
  final String apiValue;
}

class SearchKeywordGroup {
  SearchKeywordGroup({required this.name, required this.keywords}) {
    if (name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Name must not be empty.');
    }
    if (keywords.isEmpty || keywords.length > 20) {
      throw RangeError.range(keywords.length, 1, 20, 'keywords.length');
    }
  }

  final String name;
  final List<String> keywords;

  Map<String, dynamic> toJson() => {'groupName': name, 'keywords': keywords};
}

class ShoppingCategoryGroup {
  ShoppingCategoryGroup({required this.name, required this.categoryCodes}) {
    if (name.isEmpty || categoryCodes.isEmpty) {
      throw ArgumentError('Category name and codes must not be empty.');
    }
  }

  final String name;
  final List<String> categoryCodes;

  Map<String, dynamic> toJson() => {'name': name, 'param': categoryCodes};
}

class ShoppingKeywordGroup {
  ShoppingKeywordGroup({required this.name, required this.keyword}) {
    if (name.isEmpty || keyword.isEmpty) {
      throw ArgumentError('Keyword group name and keyword must not be empty.');
    }
  }

  final String name;
  final String keyword;

  Map<String, dynamic> toJson() => {
    'name': name,
    'param': [keyword],
  };
}

class TrendResponse {
  const TrendResponse({
    required this.startDate,
    required this.endDate,
    required this.timeUnit,
    required this.results,
  });

  factory TrendResponse.fromJson(Map<String, dynamic> json) => TrendResponse(
    startDate: _string(json['startDate']),
    endDate: _string(json['endDate']),
    timeUnit: _string(json['timeUnit']),
    results: _maps(
      json['results'],
    ).map(TrendResult.fromJson).toList(growable: false),
  );

  final String startDate;
  final String endDate;
  final String timeUnit;
  final List<TrendResult> results;
}

class TrendResult {
  const TrendResult({
    required this.title,
    required this.keywords,
    required this.categories,
    required this.data,
  });

  factory TrendResult.fromJson(Map<String, dynamic> json) => TrendResult(
    title: _string(json['title']),
    keywords: _strings(json['keywords'] ?? json['keyword']),
    categories: _strings(json['category']),
    data: _maps(
      json['data'],
    ).map(TrendDataPoint.fromJson).toList(growable: false),
  );

  final String title;
  final List<String> keywords;
  final List<String> categories;
  final List<TrendDataPoint> data;
}

class TrendDataPoint {
  const TrendDataPoint({required this.period, required this.ratio, this.group});

  factory TrendDataPoint.fromJson(Map<String, dynamic> json) => TrendDataPoint(
    period: _string(json['period']),
    ratio: _number(json['ratio']),
    group: json['group']?.toString(),
  );

  final String period;
  final double ratio;
  final String? group;
}

String _string(Object? value) => value?.toString() ?? '';

double _number(Object? value) => switch (value) {
  num number => number.toDouble(),
  _ => double.tryParse(_string(value)) ?? 0,
};

List<String> _strings(Object? value) => value is List
    ? value.map(_string).toList(growable: false)
    : value == null
    ? const []
    : [_string(value)];

List<Map<String, dynamic>> _maps(Object? value) => value is List
    ? value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList(growable: false)
    : const [];
