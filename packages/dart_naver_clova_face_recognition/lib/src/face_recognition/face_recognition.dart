import 'dart:typed_data';

import 'package:dart_naver_clova_face_recognition/src/face_recognition/model/face_response.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';
import 'package:http/http.dart' as http;

class FaceRecognition {
  /// Recognize face with given [Uint8List] image.
  ///
  /// Returns FaceResponse. The size of [image] must be smaller than 2MB.
  static Future<FaceResponse> recognizeFace(
    Uint8List image, {
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    if (image.lengthInBytes > 2 * 1024 * 1024) {
      throw ArgumentError.value(
        image,
        'image',
        'Image size must not exceed 2MB.',
      );
    }
    final message = await ApiUtil.requestMultipartApi(
      ServerHost.faceRecognition,
      image,
      FaceResponse.fromJson,
      headers: headers,
      client: client,
    );

    return message;
  }
}
