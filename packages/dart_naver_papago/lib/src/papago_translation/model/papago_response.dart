import 'papago_response_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'papago_response.g.dart';

@JsonSerializable(createToJson: false)
class PapagoResponse {
  const PapagoResponse({
    required this.message,
  });

  /// Response message
  final PapagoResponseMessage message;

  /// For convinient access to translatedText
  get getText => message.result.translatedText;

  factory PapagoResponse.fromJson(json) => _$PapagoResponseFromJson(json);
}
