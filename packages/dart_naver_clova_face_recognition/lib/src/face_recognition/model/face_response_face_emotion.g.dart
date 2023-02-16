// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_response_face_emotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceResponseFaceEmotion _$FaceResponseFaceEmotionFromJson(
        Map<String, dynamic> json) =>
    FaceResponseFaceEmotion(
      value: $enumDecode(_$FaceEmotionEnumMap, json['value']),
      confidence: (json['confidence'] as num).toDouble(),
    );

const _$FaceEmotionEnumMap = {
  FaceEmotion.angry: 'angry',
  FaceEmotion.disgust: 'disgust',
  FaceEmotion.fear: 'fear',
  FaceEmotion.laugh: 'laugh',
  FaceEmotion.neutral: 'neutral',
  FaceEmotion.sad: 'sad',
  FaceEmotion.surprise: 'surprise',
  FaceEmotion.smile: 'smile',
  FaceEmotion.talking: 'talking',
};
