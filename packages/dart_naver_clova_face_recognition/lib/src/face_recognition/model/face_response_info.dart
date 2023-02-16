import 'package:json_annotation/json_annotation.dart';
import 'face_response_info_size.dart';

part 'face_response_info.g.dart';

@JsonSerializable(createToJson: false)
class FaceResponseInfo {
  const FaceResponseInfo({
    this.size,
    required this.faceCount,
  });
  final FaceResponseInfoSize? size;
  final int faceCount;

  @override
  String toString() => "{ size: ${size.toString()}, faceCount: $faceCount }";
  factory FaceResponseInfo.fromJson(json) => _$FaceResponseInfoFromJson(json);
}
