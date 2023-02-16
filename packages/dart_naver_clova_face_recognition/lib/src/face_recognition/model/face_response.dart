import 'package:json_annotation/json_annotation.dart';
import 'face_response_face.dart';
import 'face_response_info.dart';

part 'face_response.g.dart';

@JsonSerializable(createToJson: false)
class FaceResponse {
  const FaceResponse({
    required this.info,
    required this.faces,
  });
  final FaceResponseInfo info;
  final List<FaceResponseFace> faces;
  @override
  String toString() =>
      '{ info: ${info.toString()}, faces: ${faces.toString()} }';
  factory FaceResponse.fromJson(json) => _$FaceResponseFromJson(json);
}
