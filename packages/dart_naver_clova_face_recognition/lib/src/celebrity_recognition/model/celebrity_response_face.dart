import 'celebrity_response_face_celebrity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'celebrity_response_face.g.dart';

@JsonSerializable(createToJson: false)
class CelebrityResponseFace {
  const CelebrityResponseFace({required this.celebrity});
  final CelebrityResponseFaceCelebrity celebrity;
  @override
  String toString() {
    return '{ celebrity: ${celebrity.toString()} }';
  }

  factory CelebrityResponseFace.fromJson(json) =>
      _$CelebrityResponseFaceFromJson(json);
}
