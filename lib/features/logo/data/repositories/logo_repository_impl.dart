import "package:fpdart/fpdart.dart" show Either;

import "../../../../core/constants/classes/params.dart";
import "../../../../core/errors/failure.dart";
import "../../../../core/services/connection/network_info.dart";

import "../../business/repositories/logo_repository.dart";
import "../data_sources/local/logo_local_data_source.dart";
import "../data_sources/remote/logo_remote_data_source.dart";

/// Data operations for the Logo collection
class LogoRepositoryImpl implements LogoRepository {
  /// Data operations for the Logo collection
  LogoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Remote data source for the Logo collection
  final LogoRemoteDataSource remoteDataSource;

  /// Local data source for the Logo collection
  final LogoLocalDataSource localDataSource;

  /// Network information for the Logo collection
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, String>> getBase64Image({
    required NoParams params,
  }) {
    // TODO: implement getBase64Image
    throw UnimplementedError();
  }
}
