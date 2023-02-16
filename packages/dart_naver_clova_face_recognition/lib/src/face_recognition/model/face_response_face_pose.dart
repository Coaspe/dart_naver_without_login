import 'package:json_annotation/json_annotation.dart';

part 'face_response_face_pose.g.dart';

enum FacePose {
  @JsonValue("part_face")
  partFace,
  @JsonValue("false_face")
  falseFace,
  sunglasses,
  @JsonValue("frontal_face")
  frontalFace,
  @JsonValue("left_face")
  leftFace,
  @JsonValue("right_face")
  rightFace,
  @JsonValue("rotate_face")
  rotateFace,
}

@JsonSerializable(createToJson: false)
@JsonSerializable(createToJson: false)
class FaceResponseFacePose {
  const FaceResponseFacePose({
    required this.value,
    required this.confidence,
  });
  final FacePose value;
  final double confidence;

  @override
  String toString() => '{ value: ${value.name}, confidence: $confidence }';

  factory FaceResponseFacePose.fromJson(json) =>
      _$FaceResponseFacePoseFromJson(json);
}
