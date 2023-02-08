import 'package:json_annotation/json_annotation.dart';
import 'package:dart_naver_papago/src/enums.dart';

part 'papago_response_result.g.dart';

@JsonSerializable(createToJson: false)
class PapagoResponseResult {
  const PapagoResponseResult({
    required this.srcLangType,
    required this.tarLangType,
    required this.translatedText,
    this.engineType,
    this.pivot,
    this.dict,
    this.tarDict,
    this.modelVer,
  });

  /// Language code of the source language to be translated.
  final LangCode srcLangType;

  /// Language code of the translated target language.
  final LangCode tarLangType;

  /// Translated result.
  final String translatedText;
  final String? engineType;
  final String? pivot;
  final String? dict;
  final String? tarDict;
  final String? modelVer;

  factory PapagoResponseResult.fromJson(json) =>
      _$PapagoResponseResultFromJson(json);
}
