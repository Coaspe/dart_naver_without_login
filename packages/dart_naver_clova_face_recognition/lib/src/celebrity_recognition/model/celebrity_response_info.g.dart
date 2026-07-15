// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebrity_response_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CelebrityResponseInfo _$CelebrityResponseInfoFromJson(
  Map<String, dynamic> json,
) => CelebrityResponseInfo(
  size: json['size'] == null
      ? null
      : CelebrityResponseInfoSize.fromJson(
          json['size'] as Map<String, dynamic>,
        ),
  faceCount: (json['faceCount'] as num).toInt(),
);
