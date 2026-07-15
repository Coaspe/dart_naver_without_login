enum CaptchaType { image, audio }

class CaptchaKeyResponse {
  const CaptchaKeyResponse(this.key);

  factory CaptchaKeyResponse.fromJson(Map<String, dynamic> json) =>
      CaptchaKeyResponse(json['key']?.toString() ?? '');

  final String key;
}

class CaptchaVerificationResponse {
  const CaptchaVerificationResponse({required this.result, this.responseTime});

  factory CaptchaVerificationResponse.fromJson(Map<String, dynamic> json) =>
      CaptchaVerificationResponse(
        result: json['result'] == true,
        responseTime: switch (json['responseTime']) {
          num value => value.toDouble(),
          String value => double.tryParse(value),
          _ => null,
        },
      );

  final bool result;
  final double? responseTime;
}
