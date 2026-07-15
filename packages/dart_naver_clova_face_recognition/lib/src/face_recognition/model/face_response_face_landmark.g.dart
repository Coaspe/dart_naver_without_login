// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response_face_landmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponseFaceLandmark _$FaceResponseFaceLandmarkFromJson(
  Map<String, dynamic> json,
) => FaceResponseFaceLandmark(
  leftEye: json['leftEye'] == null
      ? null
      : FaceResponseFaceLandmarkCoord.fromJson(
          json['leftEye'] as Map<String, dynamic>,
        ),
  rightEye: json['rightEye'] == null
      ? null
      : FaceResponseFaceLandmarkCoord.fromJson(
          json['rightEye'] as Map<String, dynamic>,
        ),
  nose: json['nose'] == null
      ? null
      : FaceResponseFaceLandmarkCoord.fromJson(
          json['nose'] as Map<String, dynamic>,
        ),
  leftMouth: json['leftMouth'] == null
      ? null
      : FaceResponseFaceLandmarkCoord.fromJson(
          json['leftMouth'] as Map<String, dynamic>,
        ),
  rightMouth: json['rightMouth'] == null
      ? null
      : FaceResponseFaceLandmarkCoord.fromJson(
          json['rightMouth'] as Map<String, dynamic>,
        ),
);
