import 'dart:typed_data';

import 'package:dart_naver_papago/dart_naver_papago.dart';
import 'package:http/http.dart' as http;

enum ImageTranslationResult { text, image }

class ImageTranslation {
  ImageTranslation._();

  static const _extensions = {'.jpg', '.jpeg', '.png', '.tiff'};

  static Future<ImageTranslationResponse> translate(
    LangCode source,
    LangCode target,
    Uint8List image, {
    required String fileName,
    ImageTranslationResult result = ImageTranslationResult.text,
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    if (source == target) {
      throw ArgumentError('Source and target languages must differ.');
    }
    if (image.isEmpty || image.lengthInBytes > 20 * 1024 * 1024) {
      throw ArgumentError.value(
        image.lengthInBytes,
        'image',
        'Image must be 1 byte to 20MB.',
      );
    }
    final lower = fileName.toLowerCase();
    if (!_extensions.any(lower.endsWith)) {
      throw ArgumentError.value(
        fileName,
        'fileName',
        'Unsupported image extension.',
      );
    }
    final url = switch (result) {
      ImageTranslationResult.text => ServerHost.papagoImageToText,
      ImageTranslationResult.image => ServerHost.papagoImageToImage,
    };
    final response = await ApiUtil.requestMultipart(
      url,
      authType: ApiAuthType.naverCloud,
      headers: headers,
      fields: {'source': source.valueToString, 'target': target.valueToString},
      files: [http.MultipartFile.fromBytes('image', image, filename: fileName)],
      client: client,
    );
    return ApiUtil.parseJsonResponse(
      response,
      ImageTranslationResponse.fromJson,
    );
  }

  static Future<ImageTranslationResponse> translateToText(
    LangCode source,
    LangCode target,
    Uint8List image, {
    required String fileName,
    Map<String, String>? headers,
    http.Client? client,
  }) => translate(
    source,
    target,
    image,
    fileName: fileName,
    headers: headers,
    client: client,
  );

  static Future<ImageTranslationResponse> translateToImage(
    LangCode source,
    LangCode target,
    Uint8List image, {
    required String fileName,
    Map<String, String>? headers,
    http.Client? client,
  }) => translate(
    source,
    target,
    image,
    fileName: fileName,
    result: ImageTranslationResult.image,
    headers: headers,
    client: client,
  );
}
