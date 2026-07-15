/// A class representing the NaverWithoutLoginApi.
///
/// This class provides methods and properties for interacting with the Naver API without login.
class NaverWithoutLoginApi {
  NaverWithoutLoginApi._();

  static final NaverWithoutLoginApi _instance = NaverWithoutLoginApi._();

  factory NaverWithoutLoginApi() => _instance;

  static String? clientId;
  static String? clientSecret;

  /// Initializes the NaverWithoutLoginApi with the provided [clientId] and [clientSecret].
  ///
  /// Throws an [ArgumentError] if [clientId] or [clientSecret] is empty.
  static void init({required String clientId, required String clientSecret}) {
    if (clientId.isEmpty || clientSecret.isEmpty) {
      throw ArgumentError("Client ID and client secret must not be empty.");
    }
    NaverWithoutLoginApi.clientId = clientId;
    NaverWithoutLoginApi.clientSecret = clientSecret;
  }
}

/// Credentials for APIs provided through NAVER Cloud Platform.
class NaverCloudApi {
  NaverCloudApi._();

  static String? _clientId;
  static String? get clientId => _clientId;

  static String? _clientSecret;
  static String? get clientSecret => _clientSecret;

  /// Initializes NAVER Cloud Platform API credentials.
  ///
  /// Throws an [ArgumentError] if [clientId] or [clientSecret] is empty.
  static void init({required String clientId, required String clientSecret}) {
    if (clientId.isEmpty || clientSecret.isEmpty) {
      throw ArgumentError("Client ID and client secret must not be empty.");
    }
    _clientId = clientId;
    _clientSecret = clientSecret;
  }
}
