import "package:hive_ce/hive.dart";

import "../../../features/logo/data/models/tables/logo_table.dart";

part "hive_adapters.g.dart";

/// Adapter for the tables of hive
@GenerateAdapters([
  AdapterSpec<LogoTable>(),
])
class HiveAdapters {}
