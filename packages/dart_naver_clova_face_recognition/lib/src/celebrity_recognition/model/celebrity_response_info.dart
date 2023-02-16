import 'celebrity_resopnse_info_size.dart';
import 'package:json_annotation/json_annotation.dart';
part 'celebrity_response_info.g.dart';

@JsonSerializable(createToJson: false)
class CelebrityResponseInfo {
  const CelebrityResponseInfo({
    this.size,
    required this.faceCount,
  });
  final CelebrityResponseInfoSize? size;
  final int faceCount;
  @override
  String toString() {
    return "{ size: ${size.toString()}, faceCount:$faceCount }";
  }

  factory CelebrityResponseInfo.fromJson(json) =>
      _$CelebrityResponseInfoFromJson(json);
}
