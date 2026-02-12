import "../../../../../core/constants/classes/params.dart";
import "../tables/logo_table.dart";

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
  LogoTable toTable(String fileName) => LogoTable(
        path: path,
        fileName: fileName,
        saved: DateTime.now().toIso8601String(),
      );
}
