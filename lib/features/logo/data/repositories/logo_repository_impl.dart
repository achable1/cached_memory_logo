import "dart:io";

import "package:fpdart/fpdart.dart" show Either;

import "../../../../core/errors/error_handler.dart";
import "../../../../core/errors/failure.dart";
import "../../../../core/services/connection/network_info.dart";
import "../../business/repositories/logo_repository.dart";
import "../data_sources/local/logo_file_data_source.dart";
import "../data_sources/local/logo_local_data_source.dart";
import "../data_sources/remote/logo_remote_data_source.dart";
import "../models/objects/logo_object.dart";
import "../models/params/params.dart";

/// Data operations for the Logo collection
class LogoRepositoryImpl implements LogoRepository {
  /// Data operations for the Logo collection
  const LogoRepositoryImpl({
    required this.remoteDataSource,
    required this.logoFileDataSource,
    required this.logoLocalDataSource,
    this.networkInfo,
  });

  /// Remote data source for the Logo collection
  final LogoRemoteDataSource remoteDataSource;

  /// Hive data source for the Logo collection
  final LogoLocalDataSource logoLocalDataSource;

  /// Local data source for the Logo collection
  final LogoFileDataSource logoFileDataSource;

  /// Network information for the Logo collection
  final NetworkInfo? networkInfo;

  @override
  Future<Either<Failure, LogoObject?>> getLogoTable({
    required LogoParams params,
  }) =>
      ErrorHandler.handleFutureCacheCall(
        () async => logoLocalDataSource.getLogoTable(params.path),
      );

  @override
  Future<Either<Failure, String>> fetchLogo({
    required LogoParams params,
  }) =>
      ErrorHandler.handleApiCall(
        () async => remoteDataSource.getBase64Logo(
          params: params,
        ),
      );

  @override
  Future<Either<Failure, void>> saveLogo({
    required SaveLogoParams params,
  }) =>
      ErrorHandler.handleFutureCacheCall(
        () async {
          final value = await logoFileDataSource.saveLogoFromBase64(
            bytes: params.bytes,
          );
          logoLocalDataSource.saveLogo(
            LogoObject(
              path: params.path,
              fileName: value,
              saved: DateTime.now().toIso8601String(),
            ),
          );
        },
      );

  @override
  Future<Either<Failure, void>> deleteLogo({
    required DeleteLogoParams params,
  }) =>
      ErrorHandler.handleFutureCacheCall(
        () async {
          await logoFileDataSource.deleteLogo(params.fileName);
          logoLocalDataSource.deleteLogo(params.id);
        },
      );

  @override
  Either<Failure, File> getLogoFile({
    required String fileName,
  }) =>
      ErrorHandler.handleCacheCall(
        () => logoFileDataSource.getLogoFile(fileName: fileName),
      );

  @override
  Either<Failure, String> getLogoPath({
    required String fileName,
  }) =>
      ErrorHandler.handleCacheCall(
        () => logoFileDataSource.getLogoPath(fileName: fileName),
      );

  @override
  Future<Either<Failure, void>> cleanupUnusedLogos({
    required Set<String> usedFileNames,
  }) =>
      ErrorHandler.handleFutureCacheCall(
        () =>
            logoFileDataSource.cleanupUnusedLogos(usedFileNames: usedFileNames),
      );
}
