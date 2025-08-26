import "../../../../../core/constants/classes/params.dart";

/// Parameters used to make the Logo request.
class LogoParams extends Params {
  /// Parameters used to make the Logo request.
  LogoParams({
    required this.path,
  });

  /// The path to the logo image.
  final String path;

  @override
  Map<String, dynamic> headers() => {
        "Authorization": "Bearer $accessToken",
      };

  @override
  Map<String, dynamic>? queries() => null;

  @override
  Map<String, dynamic> body() => {
    "path": path,
  };
}
