import 'package:json_annotation/json_annotation.dart';
part 'celebrity_response_face_celebrity.g.dart';

@JsonSerializable(createToJson: false)
class CelebrityResponseFaceCelebrity {
  const CelebrityResponseFaceCelebrity(
      {required this.value, required this.confidence});
  final String value;
  final double confidence;
  @override
  String toString() {
    return '{ value: $value, confidence: $confidence }';
  }

  factory CelebrityResponseFaceCelebrity.fromJson(json) =>
      _$CelebrityResponseFaceCelebrityFromJson(json);
}
