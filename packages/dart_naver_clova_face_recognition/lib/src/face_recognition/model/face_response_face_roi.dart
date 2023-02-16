import 'package:json_annotation/json_annotation.dart';
part 'face_response_face_roi.g.dart';

@JsonSerializable(createToJson: false)
class FaceResponseFaceROI {
  const FaceResponseFaceROI({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
  final int x;
  final int y;
  final int width;
  final int height;

  @override
  String toString() => '{ x: $x, y: $y, width: $width, height: $height }';
  factory FaceResponseFaceROI.fromJson(json) =>
      _$FaceResponseFaceROIFromJson(json);
}
