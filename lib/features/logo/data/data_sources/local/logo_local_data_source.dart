import "dart:convert" show base64Decode;
import "dart:io" show Directory, File, Platform;

import "package:crypto/crypto.dart";
import "package:path_provider/path_provider.dart";

/// Local data source for the Logo Collection
abstract class LogoLocalDataSource {
  /// Saves within the device storage the base64 logo, returns the <code>fileName</code> value
  Future<String> saveLogoFromBase64({
    required String base64String,
  });

  /// Retrieves the file from device storage from the <code>fileName</code>
  Future<File> getLogoFile({
    required String fileName,
  });

  /// Retrieves the logo path from the <code>fileName</code>
  Future<String> getLogoPath({
    required String fileName,
  });

  /// Deletes an local storaged logo from the <code>fileName</code>
  Future<void> deleteLogo({
    required String fileName,
  });

  /// Clean up the unused logos files that doesn't are in a Set of <code>fileName</code>'s provided
  Future<void> cleanupUnusedLogos({
    required Set<String> usedFileNames,
  });
}

/// Implementation of local data source for the Logo Collection
class LogoLocalDataSourceImpl implements LogoLocalDataSource {
  static const String _logoDir = "logos";

  @override
  Future<void> cleanupUnusedLogos({
    required Set<String> usedFileNames,
  }) async {
    final appDir = await getApplicationDocumentsDirectory();
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
  Future<void> deleteLogo({
    required String fileName,
  }) async {
    final file = await getLogoFile(fileName: fileName);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<File> getLogoFile({
    required String fileName,
  }) async {
    final appDir = await getApplicationDocumentsDirectory();
    return File("${appDir.path}/$_logoDir/$fileName");
  }

  @override
  Future<String> getLogoPath({
    required String fileName,
  }) async {
    final logo = await getLogoFile(fileName: fileName);
    return logo.path;
  }

  @override
  Future<String> saveLogoFromBase64({
    required String base64String,
  }) async {
    final bytes = base64Decode(base64String);

    final hash = sha256.convert(bytes).toString();
    final fileName = "$hash.png";

    final appDir = await getApplicationDocumentsDirectory();
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
