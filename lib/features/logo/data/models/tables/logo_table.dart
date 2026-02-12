import "package:hive_ce/hive.dart";

/// A table that stores logo data for local data base
class LogoTable extends HiveObject {
  /// Creates a new instance of [LogoTable].
  LogoTable({
    required this.path,
    required this.fileName,
    required this.saved,
  });

  /// Path of the logo within the fetchUrl
  final String path;

  /// File name of the saved image in app storage
  final String fileName;

  /// String representation of the DateTime when logo was saved into local database
  final String saved;
}
