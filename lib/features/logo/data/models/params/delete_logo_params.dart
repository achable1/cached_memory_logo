import "../../../../../core/constants/classes/params.dart";

/// Delete logo parameters class value
class DeleteLogoParams extends Params {
  /// Delete logo parameters class value
  DeleteLogoParams({
    required this.id,
    this.path,
    this.fileName,
  });

  /// ID for the local data base
  final int id;

  /// Path of the local storaged logo
  final String? path;

  /// File name of the logo
  final String? fileName;
}
