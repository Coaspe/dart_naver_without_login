import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_naver_clova_face_recognition/dart_naver_clova_face_recognition.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    NaverWithoutLoginApi.init(
      clientId: 'developers-id',
      clientSecret: 'developers-secret',
    );
  });

  test('recognizes a celebrity with a multipart request', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), ServerHost.celebrityRecognition);
      expect(request.headers['X-Naver-Client-Id'], 'developers-id');
      expect(
        request.headers['content-type'],
        startsWith('multipart/form-data'),
      );
      return http.Response.bytes(
        utf8.encode(
          '{"info":{"size":{"width":100,"height":100},"faceCount":1},'
          '"faces":[{"celebrity":{"value":"현빈","confidence":0.99}}]}',
        ),
        200,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
    });

    final response = await CelebrityRecognition.recognizeCelebrity(
      Uint8List.fromList([1, 2, 3]),
      client: client,
    );

    expect(response.faces.single.celebrity.value, '현빈');
  });

  test('recognizes face attributes', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), ServerHost.faceRecognition);
      return http.Response(
        '{"info":{"size":{"width":100,"height":100},"faceCount":1},'
        '"faces":[{"roi":{"x":1,"y":2,"width":3,"height":4},'
        '"landmark":{},"gender":{"value":"male","confidence":0.9},'
        '"age":{"value":"20~24","confidence":0.8},'
        '"emotion":{"value":"neutral","confidence":0.7},'
        '"pose":{"value":"frontal_face","confidence":0.6}}]}',
        200,
      );
    });

    final response = await FaceRecognition.recognizeFace(
      Uint8List.fromList([1, 2, 3]),
      client: client,
    );

    expect(response.faces.single.age.value, '20~24');
    expect(response.faces.single.pose.value, FacePose.frontalFace);
  });

  test('rejects images larger than 2MB', () {
    expect(
      CelebrityRecognition.recognizeCelebrity(Uint8List(2 * 1024 * 1024 + 1)),
      throwsArgumentError,
    );
  });
}
