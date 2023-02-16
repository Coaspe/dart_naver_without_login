import 'package:json_annotation/json_annotation.dart';
part 'face_response_face_age.g.dart';

@JsonSerializable(createToJson: false)
class FaceResponseFaceAge {
  const FaceResponseFaceAge({
    required this.value,
    required this.confidence,
  });
  final String value;
  final double confidence;

  @override
  String toString() => '{ value: $value, confidence: $confidence }';

  factory FaceResponseFaceAge.fromJson(json) =>
      _$FaceResponseFaceAgeFromJson(json);
}
