import "../../../../../core/constants/classes/params.dart";

/// Save logo parameters class value
class SaveLogoParams extends Params {
  /// Save logo parameters class value
  SaveLogoParams({
    required this.base64Logo,
    required this.path,
  });

  /// Base 64 logo value
  final String? base64Logo;

  /// Path of the logo
  final String path;
}
