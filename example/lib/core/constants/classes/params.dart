/// Base class for all params classes
abstract class Params {
  /// Base class for all params classes
  Params();

  /// Token to access the API
  String? accessToken;

  /// The headers to send to the API
  Map<String, dynamic> headers() => {
        "Authorization": "Bearer $accessToken",
      };

  /// The queries to send to the API
  Map<String, dynamic>? queries() => null;

  /// The body to send to the API
  Map<String, dynamic> body() => {};
}

/// Class to represent the no params
class NoParams extends Params {
  /// No params
  NoParams();
}
