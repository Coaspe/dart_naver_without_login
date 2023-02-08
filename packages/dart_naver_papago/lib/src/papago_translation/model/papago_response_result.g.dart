// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'papago_response_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PapagoResponseResult _$PapagoResponseResultFromJson(
        Map<String, dynamic> json) =>
    PapagoResponseResult(
      srcLangType: $enumDecode(_$LangCodeEnumMap, json['srcLangType']),
      tarLangType: $enumDecode(_$LangCodeEnumMap, json['tarLangType']),
      translatedText: json['translatedText'] as String,
      engineType: json['engineType'] as String?,
      pivot: json['pivot'] as String?,
      dict: json['dict'] as String?,
      tarDict: json['tarDict'] as String?,
      modelVer: json['modelVer'] as String?,
    );

const _$LangCodeEnumMap = {
  LangCode.ko: 'ko',
  LangCode.ja: 'ja',
  LangCode.zhCN: 'zh-CN',
  LangCode.zhTW: 'zh-TW',
  LangCode.en: 'en',
  LangCode.es: 'es',
  LangCode.fr: 'fr',
  LangCode.de: 'de',
  LangCode.pt: 'pt',
  LangCode.vi: 'vi',
  LangCode.id: 'id',
  LangCode.fa: 'fa',
  LangCode.ar: 'ar',
  LangCode.mm: 'mm',
  LangCode.th: 'th',
  LangCode.ru: 'ru',
  LangCode.it: 'it',
  LangCode.unk: 'unk',
};
