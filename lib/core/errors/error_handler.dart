import "package:dio/dio.dart";
import "package:fpdart/fpdart.dart";

import "../services/logger/logger_service.dart";
import "app_exception.dart";
import "failure.dart";

/// The [ErrorHandler] class is responsible for handling the exceptions
class ErrorHandler {
  /// Handles the exceptions that can be thrown in the application
  /// during an API call.
  ///
  /// It receives a [function] that is the API call to be executed.
  /// Returns an [Either] with the [Failure] or the [T] value.
  static Future<Either<Failure, T>> handleApiCall<T>(
    Future<T> Function() function,
  ) async {
    final logger = getLogger("ErrorHandler");
    try {
      return Right(await function());
    } on DioException catch (exception) {
      return Left(
        HttpCallFailure.fromException(
          exception,
        ),
      );
    } on EnvironmentException catch (_) {
      return Left(
        AppFailure.environment(
          errorMessage: "Ocurrió un error al obtener las variables de entorno",
        ),
      );
    } catch (e, s) {
      logger.e("Unexpected error: $e, $s");
      return Left(
        AppFailure.unexpected(e.toString()),
      );
    }
  }

  /// Handles the exceptions that can be thrown in the application
  /// during a secure cache call.
  ///
  /// It receives a [function] that is the secure cache call to be executed.
  /// Returns an [Either] with the [Failure] or the [T] value.
  static Future<Either<Failure, T>> handleFutureCacheCall<T>(
    Future<T> Function() function,
  ) async {
    try {
      return Right(await function());
    } on CacheException catch (exception) {
      return Left(AppFailure.cacheException(exception));
    } catch (e) {
      return Left(
        AppFailure.unexpected(e.toString()),
      );
    }
  }

  /// Handles the exceptions that can be thrown in the application
  /// during a cache call.
  ///
  /// It receives a [function] that is the cache call to be executed.
  /// Returns an [Either] with the [Failure] or the [T] value.
  static Either<Failure, T> handleCacheCall<T>(
    T Function() function,
  ) {
    try {
      return Right(function());
    } on CacheException catch (exception) {
      return Left(AppFailure.cacheException(exception));
    } catch (e) {
      return Left(
        AppFailure.unexpected(e.toString()),
      );
    }
  }
}
