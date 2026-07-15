// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponseInfo _$FaceResponseInfoFromJson(Map<String, dynamic> json) =>
    FaceResponseInfo(
      size: json['size'] == null
          ? null
          : FaceResponseInfoSize.fromJson(json['size'] as Map<String, dynamic>),
      faceCount: (json['faceCount'] as num).toInt(),
    );
