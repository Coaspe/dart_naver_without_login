/// A class representing the NaverWithoutLoginApi.
///
/// This class provides methods and properties for interacting with the Naver API without login.
class NaverWithoutLoginApi {
  NaverWithoutLoginApi._();

  static final NaverWithoutLoginApi _instance = NaverWithoutLoginApi._();

  factory NaverWithoutLoginApi() => _instance;

  static String? _clientId;
  static set clientId(newId) => _clientId = newId;
  static String? get clientId => _clientId;

  static String? _clientSecret;
  static set clientSecret(newSecret) => _clientSecret = newSecret;
  static String? get clientSecret => _clientSecret;

  /// Initializes the NaverWithoutLoginApi with the provided [clientId] and [clientSecret].
  ///
  /// Throws an assertion error if [clientId] or [clientSecret] is empty.
  static void init({
    required String clientId,
    required String clientSecret,
  }) {
    assert(clientId.isNotEmpty && clientSecret.isNotEmpty,
        "Invalid client id or client secret");
    _clientId = clientId;
    _clientSecret = clientSecret;
  }
}
