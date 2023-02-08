import 'package:json_annotation/json_annotation.dart';
import 'package:dart_naver_papago/src/enums.dart';

part 'language_detection_response.g.dart';

@JsonSerializable(createToJson: false)
class LanguageDetectionResponse {
  const LanguageDetectionResponse({required this.langCode});
  final LangCode langCode;

  factory LanguageDetectionResponse.fromJson(json) =>
      _$LanguageDetectionResponseFromJson(json);
}
