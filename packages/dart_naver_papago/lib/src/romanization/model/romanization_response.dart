import 'package:json_annotation/json_annotation.dart';
import 'romanization_response_result.dart';

part 'romanization_response.g.dart';

@JsonSerializable(createToJson: false)
class RomanizationResponse {
  const RomanizationResponse({
    required this.aResult,
  });
  final List<RomanizationResponseResult> aResult;
  factory RomanizationResponse.fromJson(json) =>
      _$RomanizationResponseFromJson(json);
}
