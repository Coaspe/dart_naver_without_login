import 'papago_response_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'papago_response_message.g.dart';

@JsonSerializable(createToJson: false)
class PapagoResponseMessage {
  const PapagoResponseMessage({
    this.type,
    this.service,
    this.version,
    required this.result,
  });
  @JsonKey(name: "@type")
  final String? type;
  @JsonKey(name: "@service")
  final String? service;
  @JsonKey(name: "@version")
  final String? version;
  final PapagoResponseResult result;

  /// For convinient access to translatedText
  String get getText => result.translatedText;
  factory PapagoResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$PapagoResponseMessageFromJson(json);
}
