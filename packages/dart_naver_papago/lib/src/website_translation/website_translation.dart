import 'dart:convert';

import 'package:dart_naver_papago/dart_naver_papago.dart';
import 'package:http/http.dart' as http;

class WebsiteTranslation {
  WebsiteTranslation._();

  static Future<WebsiteTranslationResponse> translate(
    LangCode source,
    LangCode target,
    String html, {
    String? glossaryKey,
    Map<String, String>? headers,
    http.Client? client,
  }) {
    if (source == target) {
      throw ArgumentError('Source and target languages must differ.');
    }
    final byteLength = utf8.encode(html).length;
    if (byteLength < 1 || byteLength > 200000) {
      throw ArgumentError.value(
        byteLength,
        'html',
        'HTML must be 1 to 200,000 UTF-8 bytes.',
      );
    }
    final body = <String, dynamic>{
      'source': source.valueToString,
      'target': target.valueToString,
      'html': html,
    };
    if (glossaryKey != null) body['glossaryKey'] = glossaryKey;
    return ApiUtil.requestApiWithoutLogin(
      ServerHost.papagoWebsiteTranslation,
      WebsiteTranslationResponse.fromJson,
      requestMethod: RequestMethod.post,
      authType: ApiAuthType.naverCloud,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        ...?headers,
      },
      body: body,
      client: client,
    );
  }
}
