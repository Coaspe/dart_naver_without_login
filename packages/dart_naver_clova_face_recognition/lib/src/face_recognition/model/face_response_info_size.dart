import 'package:json_annotation/json_annotation.dart';
part 'face_response_info_size.g.dart';

@JsonSerializable(createToJson: false)
class FaceResponseInfoSize {
  const FaceResponseInfoSize({
    required this.width,
    required this.height,
  });
  final int width;
  final int height;
  @override
  String toString() => "{ width: $width, height: $height }";
  factory FaceResponseInfoSize.fromJson(json) =>
      _$FaceResponseInfoSizeFromJson(json);
}
