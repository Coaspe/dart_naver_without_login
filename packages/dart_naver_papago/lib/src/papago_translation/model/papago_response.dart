import 'papago_response_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'papago_response.g.dart';

@JsonSerializable(createToJson: false)
class PapagoResponse {
  const PapagoResponse({required this.message});

  /// Response message
  final PapagoResponseMessage message;

  /// For convinient access to translatedText
  String get getText => message.result.translatedText;

  factory PapagoResponse.fromJson(Map<String, dynamic> json) =>
      _$PapagoResponseFromJson(json);
}
