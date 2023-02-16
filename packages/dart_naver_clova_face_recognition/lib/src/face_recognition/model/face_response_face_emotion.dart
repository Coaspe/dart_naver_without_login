import 'package:json_annotation/json_annotation.dart';
part 'face_response_face_emotion.g.dart';

enum FaceEmotion {
  angry,
  disgust,
  fear,
  laugh,
  neutral,
  sad,
  surprise,
  smile,
  talking,
}

@JsonSerializable(createToJson: false)
class FaceResponseFaceEmotion {
  const FaceResponseFaceEmotion({
    required this.value,
    required this.confidence,
  });
  final FaceEmotion value;
  final double confidence;
  @override
  String toString() => '{ value: ${value.name}, confidence: $confidence }';
  factory FaceResponseFaceEmotion.fromJson(json) =>
      _$FaceResponseFaceEmotionFromJson(json);
}
