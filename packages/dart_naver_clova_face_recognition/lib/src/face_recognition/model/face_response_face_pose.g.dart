// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response_face_pose.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponseFacePose _$FaceResponseFacePoseFromJson(
        Map<String, dynamic> json) =>
    FaceResponseFacePose(
      value: $enumDecode(_$FacePoseEnumMap, json['value']),
      confidence: (json['confidence'] as num).toDouble(),
    );

const _$FacePoseEnumMap = {
  FacePose.partFace: 'part_face',
  FacePose.falseFace: 'false_face',
  FacePose.sunglasses: 'sunglasses',
  FacePose.frontalFace: 'frontal_face',
  FacePose.leftFace: 'left_face',
  FacePose.rightFace: 'right_face',
  FacePose.rotateFace: 'rotate_face',
};
