import "package:hive_ce/hive.dart";

import "../../../../../core/services/hive/hive_boxes.dart";
import "../../models/tables/logo_table.dart";

/// Local data source for the Logo collection
abstract class LogoLocalDataSource {}

/// Local data source for the Logo collection
class LogoLocalDataSourceImpl implements LogoLocalDataSource {
  /// Local data source for the Logo collection
  LogoLocalDataSourceImpl();

  /// Fetches a logo by its path from the local database.
  Future<LogoTable?> getLogoByPath(String path) async =>
      Hive.box<LogoTable>(logoBox).get(path);

  /// Saves a logo to the local database.
  Future<void> saveLogo(LogoTable logo) async {
    await Hive.box<LogoTable>(logoBox).put(logo.path, logo);
  }

  /// Deletes a logo from the local database.
  Future<void> deleteLogo(String path) async {
    await Hive.box<LogoTable>(logoBox).delete(path);
  }
}
