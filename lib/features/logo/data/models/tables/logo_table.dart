import "package:hive_ce/hive.dart";

/// A table that stores logo data for local data base
class LogoTable extends HiveObject {
  /// Creates a new instance of [LogoTable].
  LogoTable({
    required this.path,
    required this.imageBase64,
    required this.saved,
  });

  /// Path of the logo within the fetchUrl
  final String path;

  /// Base64 encoded image data of the logo
  final String imageBase64;

  /// String representation of the DateTime when logo was saved into local database
  final String saved;
}
