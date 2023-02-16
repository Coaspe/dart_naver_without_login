import 'celebrity_response_face.dart';
import 'celebrity_response_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'celebrity_response.g.dart';

@JsonSerializable(createToJson: false)
class CelebrityResponse {
  const CelebrityResponse({required this.info, required this.faces});
  final CelebrityResponseInfo info;
  final List<CelebrityResponseFace> faces;

  @override
  String toString() {
    String total = '{ info: ${info.toString()}, faces: ${faces.toString()} }';
    return total;
  }

  factory CelebrityResponse.fromJson(json) => _$CelebrityResponseFromJson(json);
}
