import 'package:json_annotation/json_annotation.dart';
part 'face_response_face_gender.g.dart';

enum FaceGender { male, female }

@JsonSerializable(createToJson: false)
class FaceResponseFaceGender {
  const FaceResponseFaceGender({
    required this.value,
    required this.confidence,
  });
  final FaceGender value;
  final double confidence;
  @override
  String toString() => '{ value: ${value.name}, confidence: $confidence }';
  factory FaceResponseFaceGender.fromJson(json) =>
      _$FaceResponseFaceGenderFromJson(json);
}
