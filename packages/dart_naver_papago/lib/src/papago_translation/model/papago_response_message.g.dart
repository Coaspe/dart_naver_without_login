// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'papago_response_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PapagoResponseMessage _$PapagoResponseMessageFromJson(
        Map<String, dynamic> json) =>
    PapagoResponseMessage(
      type: json['@type'] as String,
      service: json['@service'] as String,
      version: json['@version'] as String,
      result: PapagoResponseResult.fromJson(json['result']),
    );
