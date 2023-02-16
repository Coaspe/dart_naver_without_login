import 'package:json_annotation/json_annotation.dart';
import 'face_response_face_landmark_coord.dart';

part 'face_response_face_landmark.g.dart';

@JsonSerializable(createToJson: false)
class FaceResponseFaceLandmark {
  const FaceResponseFaceLandmark({
    this.leftEye,
    this.rightEye,
    this.nose,
    this.leftMouth,
    this.rightMouth,
  });
  final FaceResponseFaceLandmarkCoord? leftEye;
  final FaceResponseFaceLandmarkCoord? rightEye;
  final FaceResponseFaceLandmarkCoord? nose;
  final FaceResponseFaceLandmarkCoord? leftMouth;
  final FaceResponseFaceLandmarkCoord? rightMouth;
  @override
  String toString() =>
      '{ leftEye: $leftEye, rightEye: $rightEye, nose: $nose, leftMouth: $leftMouth, rightMouth: $rightMouth }';
  factory FaceResponseFaceLandmark.fromJson(json) =>
      _$FaceResponseFaceLandmarkFromJson(json);
}
