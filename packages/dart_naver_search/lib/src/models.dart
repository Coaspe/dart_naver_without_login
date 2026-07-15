typedef SearchItemParser<T> = T Function(Map<String, dynamic> json);

class SearchResponse<T> {
  const SearchResponse({
    required this.lastBuildDate,
    required this.total,
    required this.start,
    required this.display,
    required this.items,
  });

  factory SearchResponse.fromJson(
    Map<String, dynamic> json,
    SearchItemParser<T> parseItem,
  ) {
    return SearchResponse(
      lastBuildDate: _string(json['lastBuildDate']),
      total: _integer(json['total']),
      start: _integer(json['start']),
      display: _integer(json['display']),
      items: _maps(json['items']).map(parseItem).toList(growable: false),
    );
  }

  final String lastBuildDate;
  final int total;
  final int start;
  final int display;
  final List<T> items;
}

class TextSearchItem {
  const TextSearchItem({
    required this.title,
    required this.link,
    required this.description,
  });

  factory TextSearchItem.fromJson(Map<String, dynamic> json) => TextSearchItem(
    title: _string(json['title']),
    link: _string(json['link']),
    description: _string(json['description']),
  );

  final String title;
  final String link;
  final String description;
}

class NewsSearchItem {
  const NewsSearchItem({
    required this.title,
    required this.originalLink,
    required this.link,
    required this.description,
    required this.pubDate,
  });

  factory NewsSearchItem.fromJson(Map<String, dynamic> json) => NewsSearchItem(
    title: _string(json['title']),
    originalLink: _string(json['originallink']),
    link: _string(json['link']),
    description: _string(json['description']),
    pubDate: _string(json['pubDate']),
  );

  final String title;
  final String originalLink;
  final String link;
  final String description;
  final String pubDate;
}

class EncyclopediaSearchItem {
  const EncyclopediaSearchItem({
    required this.title,
    required this.link,
    required this.description,
    required this.thumbnail,
  });

  factory EncyclopediaSearchItem.fromJson(Map<String, dynamic> json) =>
      EncyclopediaSearchItem(
        title: _string(json['title']),
        link: _string(json['link']),
        description: _string(json['description']),
        thumbnail: _string(json['thumbnail']),
      );

  final String title;
  final String link;
  final String description;
  final String thumbnail;
}

class BlogSearchItem {
  const BlogSearchItem({
    required this.title,
    required this.link,
    required this.description,
    required this.bloggerName,
    required this.bloggerLink,
    required this.postDate,
  });

  factory BlogSearchItem.fromJson(Map<String, dynamic> json) => BlogSearchItem(
    title: _string(json['title']),
    link: _string(json['link']),
    description: _string(json['description']),
    bloggerName: _string(json['bloggername']),
    bloggerLink: _string(json['bloggerlink']),
    postDate: _string(json['postdate']),
  );

  final String title;
  final String link;
  final String description;
  final String bloggerName;
  final String bloggerLink;
  final String postDate;
}

class ShoppingSearchItem {
  const ShoppingSearchItem({
    required this.title,
    required this.link,
    required this.image,
    required this.lowPrice,
    required this.highPrice,
    required this.mallName,
    required this.productId,
    required this.productType,
    required this.brand,
    required this.maker,
    required this.categories,
  });

  factory ShoppingSearchItem.fromJson(Map<String, dynamic> json) =>
      ShoppingSearchItem(
        title: _string(json['title']),
        link: _string(json['link']),
        image: _string(json['image']),
        lowPrice: _string(json['lprice']),
        highPrice: _string(json['hprice']),
        mallName: _string(json['mallName']),
        productId: _string(json['productId']),
        productType: _string(json['productType']),
        brand: _string(json['brand']),
        maker: _string(json['maker']),
        categories: [
          _string(json['category1']),
          _string(json['category2']),
          _string(json['category3']),
          _string(json['category4']),
        ].where((value) => value.isNotEmpty).toList(growable: false),
      );

  final String title;
  final String link;
  final String image;
  final String lowPrice;
  final String highPrice;
  final String mallName;
  final String productId;
  final String productType;
  final String brand;
  final String maker;
  final List<String> categories;
}

class ImageSearchItem {
  const ImageSearchItem({
    required this.title,
    required this.link,
    required this.thumbnail,
    required this.height,
    required this.width,
  });

  factory ImageSearchItem.fromJson(Map<String, dynamic> json) =>
      ImageSearchItem(
        title: _string(json['title']),
        link: _string(json['link']),
        thumbnail: _string(json['thumbnail']),
        height: _string(json['sizeheight']),
        width: _string(json['sizewidth']),
      );

  final String title;
  final String link;
  final String thumbnail;
  final String height;
  final String width;
}

class BookSearchItem {
  const BookSearchItem({
    required this.title,
    required this.link,
    required this.image,
    required this.author,
    required this.discount,
    required this.publisher,
    required this.publicationDate,
    required this.isbn,
    required this.description,
  });

  factory BookSearchItem.fromJson(Map<String, dynamic> json) => BookSearchItem(
    title: _string(json['title']),
    link: _string(json['link']),
    image: _string(json['image']),
    author: _string(json['author']),
    discount: _string(json['discount']),
    publisher: _string(json['publisher']),
    publicationDate: _string(json['pubdate']),
    isbn: _string(json['isbn']),
    description: _string(json['description']),
  );

  final String title;
  final String link;
  final String image;
  final String author;
  final String discount;
  final String publisher;
  final String publicationDate;
  final String isbn;
  final String description;
}

class CafeSearchItem {
  const CafeSearchItem({
    required this.title,
    required this.link,
    required this.description,
    required this.cafeName,
    required this.cafeUrl,
  });

  factory CafeSearchItem.fromJson(Map<String, dynamic> json) => CafeSearchItem(
    title: _string(json['title']),
    link: _string(json['link']),
    description: _string(json['description']),
    cafeName: _string(json['cafename']),
    cafeUrl: _string(json['cafeurl']),
  );

  final String title;
  final String link;
  final String description;
  final String cafeName;
  final String cafeUrl;
}

class LocalSearchItem {
  const LocalSearchItem({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapX,
    required this.mapY,
  });

  factory LocalSearchItem.fromJson(Map<String, dynamic> json) =>
      LocalSearchItem(
        title: _string(json['title']),
        link: _string(json['link']),
        category: _string(json['category']),
        description: _string(json['description']),
        telephone: _string(json['telephone']),
        address: _string(json['address']),
        roadAddress: _string(json['roadAddress']),
        mapX: _string(json['mapx']),
        mapY: _string(json['mapy']),
      );

  final String title;
  final String link;
  final String category;
  final String description;
  final String telephone;
  final String address;
  final String roadAddress;
  final String mapX;
  final String mapY;
}

class AdultSearchResponse {
  const AdultSearchResponse(this.isAdult);

  factory AdultSearchResponse.fromJson(Map<String, dynamic> json) =>
      AdultSearchResponse(_string(json['adult']) == '1');

  final bool isAdult;
}

class ErrataSearchResponse {
  const ErrataSearchResponse(this.correctedQuery);

  factory ErrataSearchResponse.fromJson(Map<String, dynamic> json) =>
      ErrataSearchResponse(_string(json['errata']));

  final String correctedQuery;
}

String _string(Object? value) => value?.toString() ?? '';

int _integer(Object? value) => switch (value) {
  int number => number,
  num number => number.toInt(),
  _ => int.tryParse(_string(value)) ?? 0,
};

List<Map<String, dynamic>> _maps(Object? value) => value is List
    ? value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList(growable: false)
    : const [];
