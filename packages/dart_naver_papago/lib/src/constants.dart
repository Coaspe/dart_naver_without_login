import 'enums.dart';

class ServerHost {
  static const baseHost = "https://openapi.naver.com";
  static const papagoTranslation = "$baseHost/v1/papago/n2mt";
  static const languageDetection = "$baseHost/v1/papago/detectLangs";
  static const romanization = "$baseHost/v1/krdict/romanization";
}

const Map<LangCode, Set<LangCode>> possibleSrcToTar = {
  LangCode.ko: {
    LangCode.en,
    LangCode.ja,
    LangCode.zhCN,
    LangCode.zhTW,
    LangCode.vi,
    LangCode.id,
    LangCode.th,
    LangCode.de,
    LangCode.ru,
    LangCode.es,
    LangCode.it,
    LangCode.fr,
  },
  LangCode.en: {
    LangCode.ja,
    LangCode.fr,
    LangCode.zhCN,
    LangCode.zhTW,
    LangCode.ko
  },
  LangCode.ja: {LangCode.zhCN, LangCode.zhTW, LangCode.ko, LangCode.en},
  LangCode.zhCN: {LangCode.zhTW, LangCode.ko, LangCode.ja},
  LangCode.zhTW: {LangCode.ko, LangCode.ja, LangCode.zhCN},
  LangCode.vi: {LangCode.ko},
  LangCode.id: {LangCode.ko},
  LangCode.th: {LangCode.ko},
  LangCode.de: {LangCode.ko},
  LangCode.ru: {LangCode.ko},
  LangCode.es: {LangCode.ko},
  LangCode.it: {LangCode.ko},
  LangCode.fr: {LangCode.ko, LangCode.en},
};
