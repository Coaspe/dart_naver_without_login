// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response_face_gender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponseFaceGender _$FaceResponseFaceGenderFromJson(
        Map<String, dynamic> json) =>
    FaceResponseFaceGender(
      value: $enumDecode(_$FaceGenderEnumMap, json['value']),
      confidence: (json['confidence'] as num).toDouble(),
    );

const _$FaceGenderEnumMap = {
  FaceGender.male: 'male',
  FaceGender.female: 'female',
};
