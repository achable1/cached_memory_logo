import "dart:typed_data";

import "../../../../../core/constants/classes/params.dart";

/// Save logo parameters class value
class SaveLogoParams extends Params {
  /// Save logo parameters class value
  SaveLogoParams({
    required this.bytes,
    required this.path,
  });

  /// Byte decoded data to save
  final Uint8List? bytes;

  /// Path of the logo
  final String path;
}
