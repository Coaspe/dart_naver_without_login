import 'package:dart_naver_clova_face_recognition/src/celebrity_recognition/celebrity_recognition.dart';
import 'package:dart_naver_clova_face_recognition/src/celebrity_recognition/model/celebrity_response.dart';
import 'package:dart_naver_clova_face_recognition/src/face_recognition/face_recognition.dart';
import 'package:dart_naver_clova_face_recognition/src/face_recognition/model/face_response.dart';
import 'package:dart_naver_clova_face_recognition/src/face_recognition/model/face_response_face_age.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'package:test/test.dart';
import 'dart:io' as io;

void main() {
  final clientId = "your-client-Id";
  final clientSecret = "your-client-secret";
  group('Recognize celebrity', () {
    setUp(() {
      NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret);
    });

    test('Recognize celebrity', () async {
      final x = await CelebrityRecognition.recognizeCelebrity(
          await io.File('your-image-path').readAsBytes());
      print(x.toString());
      expect(x, isA<CelebrityResponse>());
      expect(x.faces[0].celebrity.value, '현빈');
    });

    test('Maximum image size assertion', () async {
      try {
        final x = await CelebrityRecognition.recognizeCelebrity(
            await io.File('larger-than-2MB-image-path').readAsBytes());
        print(x.toString());
      } catch (e) {
        expect(e, isA<AssertionError>());
      }
    });
  });

  group('Recognize face', () {
    setUp(() {
      NaverWithoutLoginApi.init(clientId: clientId, clientSecret: clientSecret);
    });

    test('Recognize face', () async {
      final x = await FaceRecognition.recognizeFace(
          await io.File('your-image-path').readAsBytes());

      print(x.toString());
      expect(x, isA<FaceResponse>());
      expect(x.faces[0].age, isA<FaceResponseFaceAge>());
    });
  });
}
