// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response_face.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponseFace _$FaceResponseFaceFromJson(Map<String, dynamic> json) =>
    FaceResponseFace(
      roi: json['roi'] == null
          ? null
          : FaceResponseFaceROI.fromJson(json['roi'] as Map<String, dynamic>),
      landmark: FaceResponseFaceLandmark.fromJson(
        json['landmark'] as Map<String, dynamic>,
      ),
      gender: FaceResponseFaceGender.fromJson(
        json['gender'] as Map<String, dynamic>,
      ),
      age: FaceResponseFaceAge.fromJson(json['age'] as Map<String, dynamic>),
      emotion: FaceResponseFaceEmotion.fromJson(
        json['emotion'] as Map<String, dynamic>,
      ),
      pose: FaceResponseFacePose.fromJson(json['pose'] as Map<String, dynamic>),
    );
