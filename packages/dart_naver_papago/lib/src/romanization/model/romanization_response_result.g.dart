// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'romanization_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RomanizationResponseResult _$RomanizationResponseResultFromJson(
        Map<String, dynamic> json) =>
    RomanizationResponseResult(
      sFirstName: json['sFirstName'] as String,
      aItems: (json['aItems'] as List<dynamic>)
          .map((e) => RomanizationResponseItem.fromJson(e))
          .toList(),
    );
