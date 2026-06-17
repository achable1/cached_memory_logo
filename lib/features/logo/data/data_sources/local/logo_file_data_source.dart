import "dart:io" show Directory, File, Platform;
import "dart:typed_data";

import "package:crypto/crypto.dart";
import "package:get_it/get_it.dart";

/// Local file data source for the Logo Collection
abstract class LogoFileDataSource {
  /// Saves within the device storage the base64 logo, returns the <code>fileName</code> value
  Future<String> saveLogoFromBase64({
    required Uint8List? bytes,
  });

  /// Retrieves the file from device storage from the <code>fileName</code>
  File getLogoFile({
    required String fileName,
  });

  /// Retrieves the logo path from the <code>fileName</code>
  String getLogoPath({
    required String fileName,
  });

  /// Deletes an local storaged logo from the <code>fileName</code>
  Future deleteLogo(String? fileName);

  /// Clean up the unused logos files that doesn't are in a Set of
  /// <code>fileName</code>'s provided
  Future cleanupUnusedLogos({
    required Set<String> usedFileNames,
  });
}

/// Implementation of local file data source for the Logo Collection
class LogoFileDataSourceImpl implements LogoFileDataSource {
  static const String _logoDir = "logos";

  @override
  Future cleanupUnusedLogos({
    required Set<String> usedFileNames,
  }) async {
    final appDir = GetIt.I<Directory>();
    final logoPath = Directory("${appDir.path}/$_logoDir");

    if (!await logoPath.exists()) {
      return;
    }

    await for (final entity in logoPath.list()) {
      if (entity is! File) {
        continue;
      }

      final fileName = entity.path.split(Platform.pathSeparator).last;

      if (!usedFileNames.contains(fileName)) {
        await entity.delete();
      }
    }
  }

  @override
  Future deleteLogo(String? fileName) async {
    if (fileName == null || fileName.isEmpty) {
      return;
    }

    final file = getLogoFile(fileName: fileName);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  File getLogoFile({
    required String fileName,
  }) {
    final appDir = GetIt.I<Directory>();
    return File("${appDir.path}/$_logoDir/$fileName");
  }

  @override
  String getLogoPath({
    required String fileName,
  }) {
    final logo = getLogoFile(fileName: fileName);
    return logo.path;
  }

  @override
  Future<String> saveLogoFromBase64({
    required Uint8List? bytes,
  }) async {
    if (bytes == null) {
      return "";
    }

    final hash = sha256.convert(bytes).toString();
    final fileName = "$hash.png";

    final appDir = GetIt.I<Directory>();
    final logoPath = Directory("${appDir.path}/$_logoDir");

    if (!await logoPath.exists()) {
      await logoPath.create(recursive: true);
    }

    final file = File("${logoPath.path}/$fileName");

    if (!await file.exists()) {
      await file.writeAsBytes(bytes);
    }

    return fileName;
  }
}
