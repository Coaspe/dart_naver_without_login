// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebrity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CelebrityResponse _$CelebrityResponseFromJson(Map<String, dynamic> json) =>
    CelebrityResponse(
      info: CelebrityResponseInfo.fromJson(json['info']),
      faces: (json['faces'] as List<dynamic>)
          .map((e) => CelebrityResponseFace.fromJson(e))
          .toList(),
    );
