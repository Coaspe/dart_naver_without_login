import 'package:json_annotation/json_annotation.dart';
import 'romanization_response_item.dart';

part 'romanization_response_result.g.dart';

@JsonSerializable(createToJson: false)
class RomanizationResponseResult {
  const RomanizationResponseResult({
    required this.sFirstName,
    required this.aItems,
  });
  final String sFirstName;
  final List<RomanizationResponseItem> aItems;

  factory RomanizationResponseResult.fromJson(json) =>
      _$RomanizationResponseResultFromJson(json);
}
