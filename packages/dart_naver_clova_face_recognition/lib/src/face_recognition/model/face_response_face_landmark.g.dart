// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response_face_landmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponseFaceLandmark _$FaceResponseFaceLandmarkFromJson(
        Map<String, dynamic> json) =>
    FaceResponseFaceLandmark(
      leftEye: json['leftEye'] == null
          ? null
          : FaceResponseFaceLandmarkCoord.fromJson(json['leftEye']),
      rightEye: json['rightEye'] == null
          ? null
          : FaceResponseFaceLandmarkCoord.fromJson(json['rightEye']),
      nose: json['nose'] == null
          ? null
          : FaceResponseFaceLandmarkCoord.fromJson(json['nose']),
      leftMouth: json['leftMouth'] == null
          ? null
          : FaceResponseFaceLandmarkCoord.fromJson(json['leftMouth']),
      rightMouth: json['rightMouth'] == null
          ? null
          : FaceResponseFaceLandmarkCoord.fromJson(json['rightMouth']),
    );
