# dart_naver_search

An unofficial Dart client covering all 13 search operations in NAVER's current
non-login Open API catalog: news, encyclopedia, blog, shopping, web documents,
images, professional documents, Knowledge iN, books, cafe articles, adult-query
detection, errata conversion, and local search.

```dart
NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret);

final news = await SearchApi.news('네이버', sort: SearchSort.date);
print(news.items.first.title);
```

See the [official search documentation](https://developers.naver.com/docs/serviceapi/search/).
The package is not endorsed by NAVER.
