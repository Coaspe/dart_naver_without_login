// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response_face.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponseFace _$FaceResponseFaceFromJson(Map<String, dynamic> json) =>
    FaceResponseFace(
      roi: json['roi'] == null
          ? null
          : FaceResponseFaceROI.fromJson(json['roi']),
      landmark: FaceResponseFaceLandmark.fromJson(json['landmark']),
      gender: FaceResponseFaceGender.fromJson(json['gender']),
      age: FaceResponseFaceAge.fromJson(json['age']),
      emotion: FaceResponseFaceEmotion.fromJson(json['emotion']),
      pose: FaceResponseFacePose.fromJson(json['pose']),
    );
