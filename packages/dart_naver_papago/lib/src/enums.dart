import 'package:json_annotation/json_annotation.dart';

/// unk represents unknown
/// Enum representing language codes for translation.
///
/// The [LangCode] enum provides language codes for various languages
/// that can be used for translation purposes. Each language code is
/// represented as a value in the enum.
enum LangCode {
  ko, // Korean
  ja, // Japanese
  @JsonValue("zh-CN")
  zhCN, // Simplified Chinese
  @JsonValue("zh-TW")
  zhTW, // Traditional Chinese
  en, // English
  es, // Spanish
  fr, // French
  de, // German
  pt, // Portuguese
  vi, // Vietnamese
  id, // Indonesian
  fa, // Persian
  ar, // Arabic
  mm, // Burmese
  th, // Thai
  ru, // Russian
  it, // Italian
  unk, // Unknown
}

extension LangCodeEx on LangCode {
  String get valueToString {
    switch (this) {
      case LangCode.zhCN:
        return "zh-CN";
      case LangCode.zhTW:
        return "zh-TW";
      default:
        return name;
    }
  }
}
