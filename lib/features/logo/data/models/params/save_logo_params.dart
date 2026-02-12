import "../../../../../core/constants/classes/params.dart";
import "../tables/logo_table.dart";

/// Save logo parameters class value
class SaveLogoParams extends Params {
  
  /// Save logo parameters class value
  SaveLogoParams({required this.logoTable, required this.base64Logo});

  /// Logo hive entity
  final LogoTable logoTable;

  /// Base 64 logo value
  final String base64Logo;
}
