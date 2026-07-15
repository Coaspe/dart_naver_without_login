import 'dart:typed_data';

import 'package:dart_naver_papago/dart_naver_papago.dart';
import 'package:http/http.dart' as http;

class GlossaryApi {
  GlossaryApi._();

  static Future<GlossaryKeyResponse> create(
    String name, {
    String? description,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    if (name.isEmpty || name.runes.length > 20) {
      throw ArgumentError.value(
        name,
        'name',
        'Name must be 1 to 20 characters.',
      );
    }
    if (description != null && description.runes.length > 50) {
      throw ArgumentError.value(
        description,
        'description',
        'Description must not exceed 50 characters.',
      );
    }
    final body = <String, dynamic>{'glossaryName': name};
    if (description != null) body['description'] = description;
    return ApiUtil.requestApiWithoutLogin(
      '${ServerHost.papagoGlossary}/create',
      GlossaryKeyResponse.fromJson,
      requestMethod: RequestMethod.post,
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      body: body,
      client: client,
    );
  }

  static Future<GlossaryResponse> upload(
    String glossaryKey,
    Uint8List csv, {
    String fileName = 'glossary.csv',
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    _validateKey(glossaryKey);
    if (csv.isEmpty || !fileName.toLowerCase().endsWith('.csv')) {
      throw ArgumentError('A non-empty CSV file is required.');
    }
    final response = await ApiUtil.requestMultipart(
      '${ServerHost.papagoGlossary}/$glossaryKey/upload',
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      files: [http.MultipartFile.fromBytes('file', csv, filename: fileName)],
      client: client,
    );
    return ApiUtil.parseJsonResponse(response, GlossaryResponse.fromJson);
  }

  static Future<DownloadedFile> download(
    String glossaryKey, {
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    _validateKey(glossaryKey);
    final response = await ApiUtil.requestRaw(
      '${ServerHost.papagoGlossary}/$glossaryKey/download',
      requestMethod: RequestMethod.post,
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      client: client,
    );
    return DownloadedFile(
      bytes: response.bodyBytes,
      contentType: response.headers['content-type'],
      fileName: 'glossary-$glossaryKey.zip',
    );
  }

  static Future<GlossaryListResponse> list({
    int currentPage = 1,
    int pageSize = 20,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    if (currentPage < 1) {
      throw RangeError.range(currentPage, 1, null, 'currentPage');
    }
    if (pageSize < 1 || pageSize > 30) {
      throw RangeError.range(pageSize, 1, 30, 'pageSize');
    }
    final uri = Uri.parse('${ServerHost.papagoGlossary}/').replace(
      queryParameters: {'currentPage': '$currentPage', 'pageSize': '$pageSize'},
    );
    return ApiUtil.requestApiWithoutLogin(
      uri.toString(),
      GlossaryListResponse.fromJson,
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      client: client,
    );
  }

  static Future<GlossaryKeyResponse> delete(
    String glossaryKey, {
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateKey(glossaryKey);
    return ApiUtil.requestApiWithoutLogin(
      '${ServerHost.papagoGlossary}/$glossaryKey',
      GlossaryKeyResponse.fromJson,
      requestMethod: RequestMethod.delete,
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      client: client,
    );
  }

  static Future<GlossaryTermsResponse> addTerms(
    List<GlossaryTermInput> terms, {
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateBatch(terms.length);
    return ApiUtil.requestApiWithoutLogin(
      '${ServerHost.papagoGlossary}/replacer',
      GlossaryTermsResponse.fromJson,
      requestMethod: RequestMethod.post,
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      body: {'replacers': terms.map((term) => term.toJson()).toList()},
      client: client,
    );
  }

  static Future<GlossaryTermListResponse> listTerms(
    String glossaryKey, {
    int page = 1,
    int count = 20,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateKey(glossaryKey);
    if (page < 1 || count < 1) {
      throw RangeError('Page and count must be positive.');
    }
    final uri = Uri.parse(
      '${ServerHost.papagoGlossary}/$glossaryKey/replacer',
    ).replace(queryParameters: {'page': '$page', 'count': '$count'});
    return ApiUtil.requestApiWithoutLogin(
      uri.toString(),
      GlossaryTermListResponse.fromJson,
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      client: client,
    );
  }

  static Future<GlossaryTermsResponse> updateTerms(
    List<GlossaryTermUpdate> terms, {
    Map<String, String>? headers,
    http.Client? client,
  }) {
    _validateBatch(terms.length);
    return ApiUtil.requestApiWithoutLogin(
      '${ServerHost.papagoGlossary}/replacer',
      GlossaryTermsResponse.fromJson,
      requestMethod: RequestMethod.patch,
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      body: {'replacers': terms.map((term) => term.toJson()).toList()},
      client: client,
    );
  }

  static Future<void> deleteTerms(
    String glossaryKey,
    List<int> ids, {
    Map<String, String>? headers,
    http.Client? client,
  }) async {
    _validateKey(glossaryKey);
    _validateBatch(ids.length);
    if (ids.any((id) => id < 1)) {
      throw ArgumentError.value(ids, 'ids', 'Term IDs must be positive.');
    }
    final uri = Uri.parse('${ServerHost.papagoGlossary}/replacer').replace(
      queryParameters: {'glossaryKey': glossaryKey, 'ids': ids.join(',')},
    );
    await ApiUtil.requestRaw(
      uri.toString(),
      requestMethod: RequestMethod.delete,
      authType: ApiAuthType.naverCloudIam,
      headers: headers,
      client: client,
    );
  }

  static void _validateKey(String key) {
    if (key.isEmpty) {
      throw ArgumentError.value(
        key,
        'glossaryKey',
        'Glossary key is required.',
      );
    }
  }

  static void _validateBatch(int length) {
    if (length < 1 || length > 20) {
      throw RangeError.range(length, 1, 20, 'terms.length');
    }
  }
}
