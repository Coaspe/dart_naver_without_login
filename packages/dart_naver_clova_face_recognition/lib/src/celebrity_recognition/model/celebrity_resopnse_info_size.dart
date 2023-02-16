import 'package:json_annotation/json_annotation.dart';
part 'celebrity_resopnse_info_size.g.dart';

@JsonSerializable(createToJson: false)
class CelebrityResponseInfoSize {
  const CelebrityResponseInfoSize({required this.width, required this.height});
  final int width;
  final int height;

  @override
  String toString() {
    return "{ width: $width, height: $height }";
  }

  factory CelebrityResponseInfoSize.fromJson(json) =>
      _$CelebrityResponseInfoSizeFromJson(json);
}
