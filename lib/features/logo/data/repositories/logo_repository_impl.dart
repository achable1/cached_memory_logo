import "package:fpdart/fpdart.dart" show Either, Right;

import "../../../../core/errors/error_handler.dart";
import "../../../../core/errors/failure.dart";
import "../../business/repositories/logo_repository.dart";
import "../data_sources/local/logo_local_data_source.dart";
import "../data_sources/remote/logo_remote_data_source.dart";
import "../models/params/logo_params.dart";

/// Data operations for the Logo collection
class LogoRepositoryImpl implements LogoRepository {
  /// Data operations for the Logo collection
  const LogoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    // required this.networkInfo,
  });

  /// Remote data source for the Logo collection
  final LogoRemoteDataSource remoteDataSource;

  /// Local data source for the Logo collection
  final LogoLocalDataSource localDataSource;

  /// Network information for the Logo collection
  // final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, String>> getBase64Image({
    required LogoParams params,
  }) async {
    final logo = await localDataSource.getLogoByPath(
      params.path,
    );
    if (logo != null) {
      return Right(logo.imageBase64);
    } else if (logo != null && logo.monthSaved < DateTime.now().month) {
      await localDataSource.deleteLogo(params.path);
      return _fetchAndSaveLogo(params);
    } else {
      return _fetchAndSaveLogo(params);
    }
  }

  Future<Either<Failure, String>> _fetchAndSaveLogo(LogoParams params) =>
      ErrorHandler.handleApiCall(
        () async {
          final response = await remoteDataSource.getBase64Logo(
            params: params,
          );
          await localDataSource.saveLogo(
            params.toTable(
              response,
            ),
          );
          return response;
        },
      );
}
