import "http_call_exception.dart";

/// The Exception that is thrown if a connection error ocurrs.
class ConnectionErrorException extends HttpCallException {
  /// The constructor for the connection error general exception.
  ///
  /// Can receive a [message] and [extras] values that can be used to manage
  /// the exception.
  ConnectionErrorException({
    required super.title,
    super.message = "",
    super.type = HttpExceptions.connectionError,
  });

  /// The constructor for the server down exception.
  ///
  /// Can receive a [message] and [extras] values that can be used to manage
  /// the exception.
  ConnectionErrorException.serverDown({
    super.title = "Nuestros servidores se encuentran en mantenimiento",
    super.message = "Por favor intenta más tarde",
    super.type = HttpExceptions.serverDown,
  });

  /// The constructor for the client offline exception.
  ///
  /// Can receive a [message] and [extras] values that can be used to manage
  /// the exception.
  ConnectionErrorException.clientOffline({
    super.title = "Sin conexión a internet",
    super.message = "Revisa tu conexión a internet y vuelve a intentarlo",
    super.type = HttpExceptions.clientOffline,
  });
}
