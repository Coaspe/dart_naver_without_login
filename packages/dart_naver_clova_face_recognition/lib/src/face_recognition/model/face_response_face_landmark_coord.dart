import 'package:json_annotation/json_annotation.dart';
part 'face_response_face_landmark_coord.g.dart';

@JsonSerializable(createToJson: false)
class FaceResponseFaceLandmarkCoord {
  const FaceResponseFaceLandmarkCoord({
    required this.x,
    required this.y,
  });
  final int x;
  final int y;
  @override
  String toString() => '{ x: $x, y: $y }';
  factory FaceResponseFaceLandmarkCoord.fromJson(json) =>
      _$FaceResponseFaceLandmarkCoordFromJson(json);
}
