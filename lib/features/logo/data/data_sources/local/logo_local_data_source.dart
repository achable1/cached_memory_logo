import "package:hive_ce/hive.dart";

import "../../../../../core/services/hive/hive_boxes.dart";
import "../../models/tables/logo_table.dart";
import "../../../../../core/services/logger/logger_service.dart";
import "../../../../../core/services/logger/base64_debug.dart";

/// Local data source for the Logo collection
abstract class LogoLocalDataSource {
  /// Fetches a logo by its path from the local database.
  Future<LogoTable?> getLogoByPath(String path);

  /// Saves a logo to the local database.
  Future<void> saveLogo(LogoTable logo);

  /// Deletes a logo from the local database.
  Future<void> deleteLogo(String path);
}

/// Local data source for the Logo collection
class LogoLocalDataSourceImpl implements LogoLocalDataSource {
  /// Fetches a logo by its path from the local database.
  @override
  Future<LogoTable?> getLogoByPath(String path) async {
    final box = Hive.box<LogoTable>(logoBox);
    final logo = box.get(path);
    final logger = getLogger("LogoLocalDataSource");
    logger.i(
        "Loaded logo from hive for path=$path -> ${logo == null ? 'null' : base64Summary(logo.imageBase64)}");
    return logo;
  }

  /// Saves a logo to the local database.
  @override
  Future<void> saveLogo(LogoTable logo) async {
    final logosBox = Hive.box<LogoTable>(logoBox);
    final logger = getLogger("LogoLocalDataSource");

    if (logosBox.containsKey(logo.path)) {
      logger.w("Attempt to save duplicate logo with path=${logo.path}");
      return;
    }

    logger.i(
        "Saving logo path=${logo.path} image=${base64Summary(logo.imageBase64)}");
    await logosBox.put(logo.path, logo);
    logger.i("Saved logo with key=${logo.path}");
  }

  /// Deletes a logo from the local database.
  @override
  Future<void> deleteLogo(String path) async {
    await Hive.box<LogoTable>(logoBox).delete(path);
  }
}
