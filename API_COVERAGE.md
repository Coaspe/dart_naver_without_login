# API coverage

This inventory follows NAVER's current non-login Open API catalog and the
currently published documentation for the Papago products already represented
by this repository.

## NAVER Developers non-login APIs

| Product | Official operations | Package | Coverage |
|---|---:|---|---:|
| DataLab | 9 | `dart_naver_datalab` | 9/9 |
| Search | 13 | `dart_naver_search` | 13/13 |
| Image CAPTCHA | 3 | `dart_naver_captcha` | 3/3 |
| Audio CAPTCHA | 3 | `dart_naver_captcha` | 3/3 |
| NAVER Share | 1 URL interface | `dart_naver_web_tools` | 1/1 |
| NAVER Open Main | 1 web plugin | `dart_naver_web_tools` | 1/1 |
| NAVER app integration | 4 documented command families | `dart_naver_web_tools` | 4/4 |
| CLOVA Face Recognition | 2 | `dart_naver_clova_face_recognition` | 2/2 |
| Korean-name romanization | 1 | `dart_naver_papago` | 1/1 |

The search package covers news, encyclopedia, blog, shopping, web document,
image, professional document, Knowledge iN, book, cafe article, adult-query,
errata, and local search.

The DataLab package covers integrated search trends and all eight Shopping
Insight category/keyword and device/gender/age operations.

## NAVER Cloud Papago APIs

| Product area | Official operations | Coverage |
|---|---:|---:|
| Text translation | 1, including all optional fields | 1/1 |
| Document translation | translate, status, download | 3/3 |
| Website translation | 1 | 1/1 |
| Language detection | 1 | 1/1 |
| Glossary management | create, upload, download, list, delete | 5/5 |
| Glossary terms | add, list, update, delete | 4/4 |
| Image Translation | text result, rendered-image result | 2/2 |

## Deliberate exclusions

The old NAVER Swagger file still contains operations that are not in the current
non-login catalog. Discontinued Short URL, movie search, old NAVER Developers
Papago endpoints, old TTS, and old map endpoints are not exposed. Current
Papago endpoints use NAVER Cloud Platform as documented.

Sources:

- [NAVER Open API catalog](https://github.com/naver/naver-openapi-guide/blob/master/ko/apilist.md)
- [NAVER service API documentation](https://developers.naver.com/docs/common/openapiguide/)
- [Papago Translation API overview](https://api.ncloud-docs.com/docs/ai-naver-papagonmt)
- [Papago Image Translation overview](https://api.ncloud-docs.com/docs/ai-naver-papagoimagetranslation)
