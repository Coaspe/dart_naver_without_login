// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponse _$FaceResponseFromJson(Map<String, dynamic> json) => FaceResponse(
      info: FaceResponseInfo.fromJson(json['info']),
      faces: (json['faces'] as List<dynamic>)
          .map((e) => FaceResponseFace.fromJson(e))
          .toList(),
    );
