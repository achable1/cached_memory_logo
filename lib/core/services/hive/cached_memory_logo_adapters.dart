import "package:hive_ce/hive.dart";
import "package:once/once.dart";

import "../../../features/logo/data/models/adapters/logo_table_adapter.dart";
import "hive_boxes.dart";

/// Base class that contains the adapters config
class CachedMemoryLogoAdapters {
  /// Init method for the necessary adapters
  static Future init() async {
    Hive.registerAdapter(LogoTableAdapter());
    await Once.runOnEveryNewVersion(
      callback: () async => Hive.deleteBoxFromDisk(logoBox),
    );
  }
}
