import 'package:json_annotation/json_annotation.dart';
import 'face_response_face_age.dart';
import 'face_response_face_emotion.dart';
import 'face_response_face_gender.dart';
import 'face_response_face_landmark.dart';
import 'face_response_face_pose.dart';
import 'face_response_face_roi.dart';

part 'face_response_face.g.dart';

@JsonSerializable(createToJson: false)
class FaceResponseFace {
  const FaceResponseFace({
    this.roi,
    required this.landmark,
    required this.gender,
    required this.age,
    required this.emotion,
    required this.pose,
  });
  final FaceResponseFaceROI? roi;
  final FaceResponseFaceLandmark landmark;
  final FaceResponseFaceGender gender;
  final FaceResponseFaceAge age;
  final FaceResponseFaceEmotion emotion;
  final FaceResponseFacePose pose;

  @override
  String toString() =>
      '{ roi: ${roi.toString()}, landmark: ${landmark.toString()}, gender: ${gender.toString()}, age: ${age.toString()}, emotion: ${emotion.toString()}, pose: ${pose.toString()} }';
  factory FaceResponseFace.fromJson(json) => _$FaceResponseFaceFromJson(json);
}
