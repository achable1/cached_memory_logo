import "app_exception.dart";
import "connection/http_call_exception.dart";

/// The abstract class for the failures in the application
abstract class Failure {
  /// The abstract class for the failures in the application
  Failure({
    required this.message,
    required this.title,
    required this.level,
  });

  /// The message of the error
  final String message;

  /// The title of the error
  final String title;

  /// The level of the error
  final FailureLevel level;
}

/// The levels of the failures
enum FailureLevel {
  /// Crtical error
  error,

  /// Warning error
  warning,

  /// Information error
  info,
}

/// Failure for the Http calls
class HttpCallFailure extends Failure {
  /// Failure for the Http calls
  HttpCallFailure({
    required super.message,
    required super.title,
    required super.level,
  });

  /// Create a [HttpCallFailure] from a [HttpCallException]
  factory HttpCallFailure.fromException(HttpCallException exception) =>
      HttpCallFailure(
        title: exception.title,
        message: exception.message,
        level: _getLevel(exception.type),
      );

  static FailureLevel _getLevel(HttpExceptions type) {
    switch (type) {
      case HttpExceptions.connectionError:
      case HttpExceptions.clientOffline:
        return FailureLevel.warning;
      case HttpExceptions.serverDown:
      case HttpExceptions.serverError:
        return FailureLevel.error;
      case HttpExceptions.unauthorized:
      case HttpExceptions.expiredToken:
        return FailureLevel.warning;
      case HttpExceptions.clientError:
      case HttpExceptions.badRequest:
        return FailureLevel.warning;
      case HttpExceptions.cancelRequest:
      case HttpExceptions.other:
      case HttpExceptions.badCertificate:
        return FailureLevel.info;
    }
  }
}

/// Failure used for the application side
class AppFailure extends Failure {
  /// Failure used for the application side
  AppFailure({
    required super.message,
    required super.title,
    super.level = FailureLevel.error,
  });

  /// Create an [AppFailure]
  ///
  /// [message] is the message of the error
  ///
  /// This is used when the error is unexpected
  factory AppFailure.unexpected(String message) => AppFailure(
        title: "Ocurrió un error en la aplicación",
        message: message,
      );

  /// Create an [AppFailure]
  ///
  /// [errorMessage] is the message of the error
  ///
  /// This is used when the error is related to the environment
  factory AppFailure.environment({
    required String errorMessage,
  }) =>
      AppFailure(
        title: "Ocurrió un error en la aplicación",
        message: errorMessage,
      );

  /// Create an [AppFailure]
  ///
  /// [exception] is the exception that was thrown
  ///
  /// This is used when the error is related to cache operations
  factory AppFailure.cacheException(CacheException exception) => AppFailure(
        title: exception.title,
        message: exception.message,
        level: FailureLevel.error,
      );
}
