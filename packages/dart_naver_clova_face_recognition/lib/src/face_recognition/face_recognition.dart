import 'dart:typed_data';

import 'package:dart_naver_clova_face_recognition/src/face_recognition/model/face_response.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';

class FaceRecognition {
  /// Recognize face with given [Uint8List] image.
  ///
  /// Returns FaceResponse. The size of [image] must be smaller than 2MB.
  static Future<FaceResponse> recognizeFace(Uint8List image,
      {Map<String, String>? headers}) async {
    assert(image.lengthInBytes < 2097152,
        "Size of image must be smaller than 2MB.");
    FaceResponse message = await ApiUtil.requestMultipartApi(
      ServerHost.faceRecognition,
      image,
      FaceResponse.fromJson,
      headers: headers,
    );

    return message;
  }
}
