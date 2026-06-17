import "../../../../../core/constants/classes/params.dart";
import "../objects/logo_object.dart";

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

  /// Converts the LogoParams to a LogoTable for save in local DB
  LogoObject toTable(String fileName) => LogoObject(
        path: path,
        fileName: fileName,
        saved: DateTime.now().toIso8601String(),
      );
}
