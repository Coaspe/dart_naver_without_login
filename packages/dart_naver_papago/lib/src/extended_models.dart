import 'dart:convert';
import 'dart:typed_data';

enum DocumentTranslationStatus {
  waiting('WAITING'),
  progress('PROGRESS'),
  complete('COMPLETE'),
  failed('FAILED'),
  unknown('');

  const DocumentTranslationStatus(this.apiValue);
  final String apiValue;

  static DocumentTranslationStatus parse(Object? value) => values.firstWhere(
    (status) => status.apiValue == value,
    orElse: () => unknown,
  );
}

class DocumentTranslationRequest {
  const DocumentTranslationRequest(this.requestId);

  factory DocumentTranslationRequest.fromJson(Map<String, dynamic> json) =>
      DocumentTranslationRequest(_string(_map(json['data'])['requestId']));

  final String requestId;
}

class DocumentTranslationProgress {
  const DocumentTranslationProgress({
    required this.status,
    this.progressPercent,
    this.errorCode,
    this.errorMessage,
  });

  factory DocumentTranslationProgress.fromJson(Map<String, dynamic> json) {
    final data = _map(json['data']);
    return DocumentTranslationProgress(
      status: DocumentTranslationStatus.parse(data['status']),
      progressPercent: _nullableInteger(data['progressPercent']),
      errorCode: data['errCode']?.toString(),
      errorMessage: data['errMsg']?.toString(),
    );
  }

  final DocumentTranslationStatus status;
  final int? progressPercent;
  final String? errorCode;
  final String? errorMessage;
}

class DownloadedFile {
  const DownloadedFile({required this.bytes, this.fileName, this.contentType});

  final Uint8List bytes;
  final String? fileName;
  final String? contentType;
}

class WebsiteTranslationResponse {
  const WebsiteTranslationResponse({
    required this.statusCode,
    required this.html,
  });

  factory WebsiteTranslationResponse.fromJson(Map<String, dynamic> json) =>
      WebsiteTranslationResponse(
        statusCode: _integer(json['status_code']),
        html: _string(json['data']),
      );

  final int statusCode;
  final String html;
}

class GlossaryKeyResponse {
  const GlossaryKeyResponse(this.glossaryKey);

  factory GlossaryKeyResponse.fromJson(Map<String, dynamic> json) =>
      GlossaryKeyResponse(_string(_map(json['data'])['glossaryKey']));

  final String glossaryKey;
}

class Glossary {
  const Glossary({
    required this.glossaryKey,
    required this.name,
    required this.wordCount,
    required this.description,
    required this.createdDateTime,
    required this.updatedDateTime,
  });

  factory Glossary.fromJson(Map<String, dynamic> json) => Glossary(
    glossaryKey: _string(json['glossaryKey']),
    name: _string(json['glossaryName']),
    wordCount: _integer(json['wordCount']),
    description: _string(json['description']),
    createdDateTime: _integer(json['createdDateTime']),
    updatedDateTime: _integer(json['updatedDateTime']),
  );

  final String glossaryKey;
  final String name;
  final int wordCount;
  final String description;
  final int createdDateTime;
  final int updatedDateTime;
}

class GlossaryResponse {
  const GlossaryResponse(this.glossary);

  factory GlossaryResponse.fromJson(Map<String, dynamic> json) =>
      GlossaryResponse(Glossary.fromJson(_map(json['data'])));

  final Glossary glossary;
}

class GlossaryListResponse {
  const GlossaryListResponse({
    required this.glossaries,
    required this.currentPage,
    required this.totalPage,
    required this.currentGlossaryCount,
    required this.totalGlossaryCount,
  });

  factory GlossaryListResponse.fromJson(Map<String, dynamic> json) =>
      GlossaryListResponse(
        glossaries: _maps(
          json['data'],
        ).map(Glossary.fromJson).toList(growable: false),
        currentPage: _integer(json['currentPage']),
        totalPage: _integer(json['totalPage']),
        currentGlossaryCount: _integer(json['currentGlossaryCount']),
        totalGlossaryCount: _integer(json['totalGlossaryCount']),
      );

  final List<Glossary> glossaries;
  final int currentPage;
  final int totalPage;
  final int currentGlossaryCount;
  final int totalGlossaryCount;
}

class GlossaryTermInput {
  GlossaryTermInput({
    required this.glossaryKey,
    required this.source,
    required this.target,
    required this.triggerText,
    required this.replaceText,
  }) {
    if ([
      glossaryKey,
      source,
      target,
      triggerText,
      replaceText,
    ].any((value) => value.isEmpty)) {
      throw ArgumentError('Glossary term fields must not be empty.');
    }
  }

  final String glossaryKey;
  final String source;
  final String target;
  final String triggerText;
  final String replaceText;

  Map<String, dynamic> toJson() => {
    'glossaryKey': glossaryKey,
    'source': source,
    'target': target,
    'triggerText': triggerText,
    'replaceText': replaceText,
  };
}

class GlossaryTermUpdate {
  GlossaryTermUpdate({
    required this.glossaryKey,
    required this.id,
    required this.replaceText,
  }) {
    if (glossaryKey.isEmpty || replaceText.isEmpty || id < 1) {
      throw ArgumentError('Glossary key, positive ID, and text are required.');
    }
  }

  final String glossaryKey;
  final int id;
  final String replaceText;

  Map<String, dynamic> toJson() => {
    'glossaryKey': glossaryKey,
    'id': id,
    'replaceText': replaceText,
  };
}

class GlossaryTerm {
  const GlossaryTerm({
    required this.id,
    required this.glossaryKey,
    required this.source,
    required this.target,
    required this.triggerText,
    required this.replaceText,
    required this.createdDateTime,
    required this.updatedDateTime,
  });

  factory GlossaryTerm.fromJson(Map<String, dynamic> json) => GlossaryTerm(
    id: _integer(json['id']),
    glossaryKey: _string(json['glossaryKey']),
    source: _string(json['source']),
    target: _string(json['target']),
    triggerText: _string(json['triggerText']),
    replaceText: _string(json['replaceText']),
    createdDateTime: _string(json['createdDateTime']),
    updatedDateTime: _string(json['updatedDateTime']),
  );

  final int id;
  final String glossaryKey;
  final String source;
  final String target;
  final String triggerText;
  final String replaceText;
  final String createdDateTime;
  final String updatedDateTime;
}

class GlossaryTermsResponse {
  const GlossaryTermsResponse(this.terms);

  factory GlossaryTermsResponse.fromJson(Map<String, dynamic> json) =>
      GlossaryTermsResponse(
        _maps(
          json['replacers'],
        ).map(GlossaryTerm.fromJson).toList(growable: false),
      );

  final List<GlossaryTerm> terms;
}

class GlossaryTermListResponse {
  const GlossaryTermListResponse({
    required this.terms,
    required this.totalPageCount,
    required this.totalItemCount,
    required this.page,
    required this.count,
  });

  factory GlossaryTermListResponse.fromJson(Map<String, dynamic> json) {
    final paging = _map(json['paging']);
    return GlossaryTermListResponse(
      terms: _maps(
        json['replacerList'],
      ).map(GlossaryTerm.fromJson).toList(growable: false),
      totalPageCount: _integer(paging['totalPageCount']),
      totalItemCount: _integer(paging['totalItemCount']),
      page: _integer(paging['page']),
      count: _integer(paging['count']),
    );
  }

  final List<GlossaryTerm> terms;
  final int totalPageCount;
  final int totalItemCount;
  final int page;
  final int count;
}

class ImagePoint {
  const ImagePoint({required this.x, required this.y});

  factory ImagePoint.fromJson(Map<String, dynamic> json) =>
      ImagePoint(x: _integer(json['x']), y: _integer(json['y']));

  final int x;
  final int y;
}

class ImageBounds {
  const ImageBounds({
    this.leftBottom,
    this.leftTop,
    this.rightBottom,
    this.rightTop,
  });

  factory ImageBounds.fromJson(Map<String, dynamic> json) => ImageBounds(
    leftBottom: _point(json['LB']),
    leftTop: _point(json['LT']),
    rightBottom: _point(json['RB']),
    rightTop: _point(json['RT']),
  );

  final ImagePoint? leftBottom;
  final ImagePoint? leftTop;
  final ImagePoint? rightBottom;
  final ImagePoint? rightTop;
}

class ImageTranslationWord {
  const ImageTranslationWord({required this.sourceText, required this.bounds});

  factory ImageTranslationWord.fromJson(Map<String, dynamic> json) =>
      ImageTranslationWord(
        sourceText: _string(json['sourceText']),
        bounds: ImageBounds.fromJson(json),
      );

  final String sourceText;
  final ImageBounds bounds;
}

class ImageTranslationLine {
  const ImageTranslationLine({required this.bounds, required this.words});

  factory ImageTranslationLine.fromJson(Map<String, dynamic> json) =>
      ImageTranslationLine(
        bounds: ImageBounds.fromJson(json),
        words: _maps(
          json['words'],
        ).map(ImageTranslationWord.fromJson).toList(growable: false),
      );

  final ImageBounds bounds;
  final List<ImageTranslationWord> words;
}

class ImageTranslationBlock {
  const ImageTranslationBlock({
    required this.sourceLanguage,
    required this.sourceText,
    required this.targetText,
    required this.lines,
  });

  factory ImageTranslationBlock.fromJson(Map<String, dynamic> json) =>
      ImageTranslationBlock(
        sourceLanguage: _string(json['sourceLang']),
        sourceText: _string(json['sourceText']),
        targetText: _string(json['targetText']),
        lines: _maps(
          json['lines'],
        ).map(ImageTranslationLine.fromJson).toList(growable: false),
      );

  final String sourceLanguage;
  final String sourceText;
  final String targetText;
  final List<ImageTranslationLine> lines;
}

class ImageTranslationData {
  const ImageTranslationData({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.sourceText,
    required this.targetText,
    required this.blocks,
    required this.bounds,
    this.renderedImage,
  });

  factory ImageTranslationData.fromJson(Map<String, dynamic> json) =>
      ImageTranslationData(
        sourceLanguage: _string(json['sourceLang']),
        targetLanguage: _string(json['targetLang']),
        sourceText: _string(json['sourceText']),
        targetText: _string(json['targetText']),
        blocks: _maps(
          json['blocks'],
        ).map(ImageTranslationBlock.fromJson).toList(growable: false),
        bounds: ImageBounds.fromJson(json),
        renderedImage: json['renderedImage']?.toString(),
      );

  final String sourceLanguage;
  final String targetLanguage;
  final String sourceText;
  final String targetText;
  final List<ImageTranslationBlock> blocks;
  final ImageBounds bounds;
  final String? renderedImage;

  Uint8List? get renderedImageBytes {
    final value = renderedImage;
    return value == null || value.isEmpty ? null : base64Decode(value);
  }
}

class ImageTranslationResponse {
  const ImageTranslationResponse(this.data);

  factory ImageTranslationResponse.fromJson(Map<String, dynamic> json) =>
      ImageTranslationResponse(
        ImageTranslationData.fromJson(_map(json['data'])),
      );

  final ImageTranslationData data;
}

String _string(Object? value) => value?.toString() ?? '';

int _integer(Object? value) => _nullableInteger(value) ?? 0;

int? _nullableInteger(Object? value) => switch (value) {
  int number => number,
  num number => number.toInt(),
  String text => int.tryParse(text),
  _ => null,
};

Map<String, dynamic> _map(Object? value) =>
    value is Map ? Map<String, dynamic>.from(value) : const {};

List<Map<String, dynamic>> _maps(Object? value) => value is List
    ? value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList(growable: false)
    : const [];

ImagePoint? _point(Object? value) =>
    value is Map ? ImagePoint.fromJson(Map<String, dynamic>.from(value)) : null;
