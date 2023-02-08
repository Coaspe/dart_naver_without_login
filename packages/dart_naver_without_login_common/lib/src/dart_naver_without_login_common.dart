class NaverWithoutLoginApi {
  NaverWithoutLoginApi._();
  static String? _clientId;
  static set clientId(newId) => _clientId = newId;
  static String? get clientId => _clientId;

  static String? _clientSecret;
  static set clientSecret(newSecret) => _clientSecret = newSecret;
  static String? get clientSecret => _clientSecret;

  static void init({
    required String clientId,
    required String clientSecret,
  }) {
    assert(clientId.isNotEmpty && clientSecret.isNotEmpty,
        "Invaild client id or client secret");
    _clientId = clientId;
    _clientSecret = clientSecret;
  }
}
