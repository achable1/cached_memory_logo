import "dart:io" show File;

import "package:fpdart/fpdart.dart";

import "../../../../core/errors/failure.dart";
import "../../data/models/params/params.dart";

/// Data operations for the Logo collection
abstract class LogoRepository {
  /// Fetches the fileName metadata storaged of the logo
  Future<Either<Failure, String?>> getLogoFileName({
    required LogoParams params,
  });

  /// Fetches remote data for the logo
  Future<Either<Failure, String>> fetchLogo({
    required LogoParams params,
  });

  /// Saves a logo locally
  Future<Either<Failure, void>> saveLogo({
    required SaveLogoParams params,
  });

  /// Deletes a logo locally
  Future<Either<Failure, void>> deleteLogo({
    required DeleteLogoParams params,
  });

  /// Get logo file from fileName provided
  Future<Either<Failure, File>> getLogoFile({
    required String fileName,
  });

  /// Get logo path from fileName provided
  Future<Either<Failure, String>> getLogoPath({
    required String fileName,
  });

  /// Clean the logos that doesn't appear on the usedFileNames provided
  Future<Either<Failure, void>> cleanupUnusedLogos({
    required Set<String> usedFileNames,
  });
}
