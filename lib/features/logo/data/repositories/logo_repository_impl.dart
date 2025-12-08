import "package:fpdart/fpdart.dart" show Either, Right;

import "../../../../core/errors/error_handler.dart";
import "../../../../core/errors/failure.dart";
import "../../business/repositories/logo_repository.dart";
import "../data_sources/local/logo_local_data_source.dart";
import "../data_sources/remote/logo_remote_data_source.dart";
import "../models/params/logo_params.dart";
import "../../../../core/services/logger/logger_service.dart";
import "../../../../core/services/logger/base64_debug.dart";

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
    final logger = getLogger("LogoRepositoryImpl");
    final logo = await localDataSource.getLogoByPath(params.path);
    if (logo != null) {
      logger.i(
          "Logo found in local DB for ${params.path}: ${base64Summary(logo.imageBase64)} monthSaved=${logo.monthSaved}");
      if (logo.monthSaved < DateTime.now().month) {
        logger.i("Local logo is stale, deleting and fetching new");
        await localDataSource.deleteLogo(params.path);
        return _fetchAndSaveLogo(params);
      }
      return Right(logo.imageBase64);
    } else {
      logger.i("Logo not found locally, fetching remote for ${params.path}");
      return _fetchAndSaveLogo(params);
    }
  }

  Future<Either<Failure, String>> _fetchAndSaveLogo(LogoParams params) =>
      ErrorHandler.handleApiCall(
        () async {
          final response = await remoteDataSource.getBase64Logo(
            params: params,
          );
          final logger = getLogger("LogoRepositoryImpl");
          logger.i("Fetched remote base64: ${base64Summary(response)}");
          await localDataSource.saveLogo(params.toTable(response));
          logger.i("Saved remote logo to local for ${params.path}");
          return response;
        },
      );
}
