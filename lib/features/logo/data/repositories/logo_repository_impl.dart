import "dart:io";

import "package:fpdart/fpdart.dart" show Either;

import "../../../../core/errors/error_handler.dart";
import "../../../../core/errors/failure.dart";
import "../../../../core/services/connection/network_info.dart";
import "../../business/repositories/logo_repository.dart";
import "../data_sources/local/logo_hive_data_source.dart";
import "../data_sources/local/logo_local_data_source.dart";
import "../data_sources/remote/logo_remote_data_source.dart";
import "../models/params/params.dart";

/// Data operations for the Logo collection
class LogoRepositoryImpl implements LogoRepository {
  /// Data operations for the Logo collection
  const LogoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.hiveDataSource,
    this.networkInfo,
    this.toleranceRange = const Duration(days: 30),
  });

  /// Remote data source for the Logo collection
  final LogoRemoteDataSource remoteDataSource;

  /// Hive data source for the Logo collection
  final LogoHiveDataSource hiveDataSource;

  /// Local data source for the Logo collection
  final LogoLocalDataSource localDataSource;

  /// Network information for the Logo collection
  final NetworkInfo? networkInfo;

  /// Represents the difference between the saved DateTime and the time that you want to fetch again remote logo data,
  /// this automatically sets for 30 days, but, for testing or development flows, you can set into less time
  final Duration toleranceRange;

  @override
  Future<Either<Failure, String?>> getLogoFileName({
    required LogoParams params,
  }) =>
      ErrorHandler.handleCacheCall(
        () async => hiveDataSource.getLogoFileName(params.path),
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
      ErrorHandler.handleCacheCall(
        () async {
          await hiveDataSource.saveLogo(params.logoTable);
          await localDataSource.saveLogoFromBase64(
            base64String: params.base64Logo,
          );
        },
      );

  @override
  Future<Either<Failure, void>> deleteLogo({
    required DeleteLogoParams params,
  }) =>
      ErrorHandler.handleCacheCall(
        () async {
          await hiveDataSource.deleteLogo(params.path);
          await localDataSource.deleteLogo(fileName: params.fileName);
        },
      );

  @override
  Future<Either<Failure, File>> getLogoFile({
    required String fileName,
  }) =>
      ErrorHandler.handleCacheCall(
        () => localDataSource.getLogoFile(fileName: fileName),
      );

  @override
  Future<Either<Failure, String>> getLogoPath({
    required String fileName,
  }) =>
      ErrorHandler.handleCacheCall(
        () => localDataSource.getLogoPath(fileName: fileName),
      );

  @override
  Future<Either<Failure, void>> cleanupUnusedLogos({
    required Set<String> usedFileNames,
  }) => ErrorHandler.handleCacheCall(
    () => localDataSource.cleanupUnusedLogos(usedFileNames: usedFileNames),
  );
}
