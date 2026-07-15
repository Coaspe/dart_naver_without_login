import 'dart:typed_data';

import 'package:dart_naver_papago/dart_naver_papago.dart';
import 'package:http/http.dart' as http;

class DocumentTranslation {
  DocumentTranslation._();

  static const _extensions = {'.docx', '.pptx', '.xlsx', '.pdf', '.hwp'};

  static Future<DocumentTranslationRequest> translate(
    LangCode source,
    LangCode target,
    Uint8List file, {
    required String fileName,
    String? glossaryKey,
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    _validateRequest(source, target, file, fileName);
    final fields = {
      'source': source.valueToString,
      'target': target.valueToString,
    };
    if (glossaryKey != null) fields['glossaryKey'] = glossaryKey;
    final response = await ApiUtil.requestMultipart(
      '${ServerHost.papagoDocumentTranslation}/translate',
      authType: ApiAuthType.naverCloud,
      headers: headers,
      fields: fields,
      files: [http.MultipartFile.fromBytes('file', file, filename: fileName)],
      client: client,
    );
    return ApiUtil.parseJsonResponse(
      response,
      DocumentTranslationRequest.fromJson,
    );
  }

  static Future<DocumentTranslationProgress> status(
    String requestId, {
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateId(requestId);
    final uri = Uri.parse(
      '${ServerHost.papagoDocumentTranslation}/status',
    ).replace(queryParameters: {'requestId': requestId});
    return ApiUtil.requestApiWithoutLogin(
      uri.toString(),
      DocumentTranslationProgress.fromJson,
      authType: ApiAuthType.naverCloud,
      headers: headers,
      client: client,
    );
  }

  static Future<DownloadedFile> download(
    String requestId, {
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    _validateId(requestId);
    final uri = Uri.parse(
      '${ServerHost.papagoDocumentTranslation}/download',
    ).replace(queryParameters: {'requestId': requestId});
    final response = await ApiUtil.requestRaw(
      uri.toString(),
      authType: ApiAuthType.naverCloud,
      headers: headers,
      client: client,
    );
    return DownloadedFile(
      bytes: response.bodyBytes,
      fileName: _fileName(response.headers['content-disposition']),
      contentType: response.headers['content-type'],
    );
  }

  static void _validateRequest(
    LangCode source,
    LangCode target,
    Uint8List file,
    String fileName,
  ) {
    if (source == target) {
      throw ArgumentError('Source and target languages must differ.');
    }
    if (file.isEmpty || file.lengthInBytes > 100 * 1024 * 1024) {
      throw ArgumentError.value(
        file.lengthInBytes,
        'file',
        'File must be 1 byte to 100MB.',
      );
    }
    final lower = fileName.toLowerCase();
    if (!_extensions.any(lower.endsWith)) {
      throw ArgumentError.value(
        fileName,
        'fileName',
        'Unsupported document extension.',
      );
    }
  }

  static void _validateId(String requestId) {
    if (requestId.isEmpty) {
      throw ArgumentError.value(
        requestId,
        'requestId',
        'Request ID is required.',
      );
    }
  }

  static String? _fileName(String? disposition) {
    if (disposition == null) return null;
    final match = RegExp(
      "filename\\*?=(?:UTF-8''|\")?([^\";]+)",
      caseSensitive: false,
    ).firstMatch(disposition);
    final value = match?.group(1);
    return value == null ? null : Uri.decodeComponent(value);
  }
}
