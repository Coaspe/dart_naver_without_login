import 'dart:typed_data';

import 'package:dart_naver_clova_face_recognition/src/celebrity_recognition/model/celebrity_response.dart';
import 'package:dart_naver_without_login_common/dart_naver_without_login_common.dart';

class CelebrityRecognition {
  /// Recognize celebrity with given Uint8List image.
  ///
  /// Returns CelebrityResponse. The size of [image] must be smaller than 2MB.
  static Future<CelebrityResponse> recognizeCelebrity(Uint8List image,
      {Map<String, String>? headers}) async {
    assert(image.lengthInBytes < 2097152,
        "Size of image must be smaller than 2MB.");
    CelebrityResponse message = await ApiUtil.requestMultipartApi(
      ServerHost.celebrityRecognition,
      image,
      CelebrityResponse.fromJson,
      headers: headers,
    );

    return message;
  }
}
