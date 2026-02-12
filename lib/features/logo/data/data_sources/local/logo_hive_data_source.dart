import "package:hive_ce/hive.dart";

import "../../../../../core/services/hive/hive_boxes.dart";
import "../../models/tables/logo_table.dart";

/// Hive data source for the Logo collection
abstract class LogoHiveDataSource {
  /// Fetches a logo by its path from the hive database.
  Future<String?> getLogoFileName(String path);

  /// Saves a logo to the Hive database.
  Future<void> saveLogo(LogoTable logo);

  /// Deletes a logo from the Hive database.
  Future<void> deleteLogo(String path);
}

/// Hive data source for the Logo collection
class LogoHiveDataSourceImpl implements LogoHiveDataSource {
  /// Fetches a logo by its path from the Hive database.
  @override
  Future<String?> getLogoFileName(String path) async {
    final box = Hive.box<LogoTable>(logoBox);
    final logo = box.get(path);
    return logo?.fileName;
  }

  /// Saves a logo to the Hive database.
  @override
  Future<void> saveLogo(LogoTable logo) async {
    final logosBox = Hive.box<LogoTable>(logoBox);

    if (logosBox.containsKey(logo.path)) {
      return;
    }

    await logosBox.put(logo.path, logo);
  }

  /// Deletes a logo from the Hive database.
  @override
  Future<void> deleteLogo(String path) async => Hive.box<LogoTable>(logoBox).delete(path);
}
