import 'package:json_annotation/json_annotation.dart';

part 'romanization_response_item.g.dart';

@JsonSerializable(createToJson: false)
class RomanizationResponseItem {
  const RomanizationResponseItem({
    required this.name,
    required this.score,
  });
  final String name;
  final String score;

  factory RomanizationResponseItem.fromJson(json) =>
      _$RomanizationResponseItemFromJson(json);
}
