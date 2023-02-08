import 'package:json_annotation/json_annotation.dart';

/// unk represents unknown
enum LangCode {
  ko,
  ja,
  @JsonValue("zh-CN")
  zhCN,
  @JsonValue("zh-TW")
  zhTW,
  en,
  es,
  fr,
  de,
  pt,
  vi,
  id,
  fa,
  ar,
  mm,
  th,
  ru,
  it,
  unk
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
