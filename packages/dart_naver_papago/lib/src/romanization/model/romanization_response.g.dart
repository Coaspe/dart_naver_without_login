// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'romanization_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RomanizationResponse _$RomanizationResponseFromJson(
        Map<String, dynamic> json) =>
    RomanizationResponse(
      aResult: (json['aResult'] as List<dynamic>)
          .map((e) => RomanizationResponseResult.fromJson(e))
          .toList(),
    );
