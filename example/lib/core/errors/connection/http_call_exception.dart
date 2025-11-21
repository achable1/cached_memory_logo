// ignore_for_file: lines_longer_than_80_chars

export "client_error_exception.dart";
export "connection_error_exception.dart";
export "server_error_exception.dart";

/// The Exception that is thrown if an error ocurrs.
class HttpCallException implements Exception {
  /// The constructor for the exception.
  ///
  /// Receive the [type] of the exception and [extras] values that can be used to manage the exception.
  HttpCallException({
    required this.message,
    required this.title,
    this.type = HttpExceptions.other,
    this.data,
  });

  /// The type of Exception.
  ///
  /// Can be as shown in the table below:
  ///
  /// |Type                      | Case                                                   |
  /// |--------------------------|--------------------------------------------------------|
  /// | `ClientError`            | When the status code is between 300 and 499            |
  /// | `ExpiredToken`           | When access token is expired & need to be refresh      |
  /// | `Unauthorized`           | When an error occurred with the authorization          |
  /// | `ServerError`            | When the status code is between 500 and 599            |
  /// | `ConnectionError`        | When a connection error occurs and cannot be specified |
  /// | `ServerDown`             | When cannot connect to the backend                     |
  /// | `ClientOffline`          | When cannot connect to `yahoo.com`                     |
  /// | `Other`                  | When any other `Exception` occurs                      |
  HttpExceptions type;

  /// The title of the exception.
  String title;

  /// The message error from the call.
  String message;

  /// The response data from the call.
  dynamic data;
}

/// The types of the Http Exceptions
enum HttpExceptions {
  /// Some error on the client side
  clientError,

  /// When access token is expired & need to be refresh
  expiredToken,

  /// When an error occurred with the authorization
  unauthorized,

  /// When the status code is between 300 and 499
  badRequest,

  /// When the request is canceled
  cancelRequest,

  /// Some error on the server side
  serverError,

  /// The certificate is invalid or expired
  badCertificate,

  /// When a connection error occurs and cannot be specified
  connectionError,

  /// When cannot connect to the backend
  serverDown,

  /// When the device is offline
  clientOffline,

  /// Unspecified error
  other,
}
