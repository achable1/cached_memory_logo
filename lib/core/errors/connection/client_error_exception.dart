import "http_call_exception.dart";

/// The Exception that is thrown if a client error ocurrs.
class ClientErrorException extends HttpCallException {
  /// The constructor for the client error general exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras]
  /// values that can be used to manage the exception.
  ClientErrorException({
    required super.title,
    super.data,
    super.message = "",
    super.type = HttpExceptions.clientError,
  });

  /// The constructor for the unauthorized exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras]
  /// values that can be used to manage the exception.
  ClientErrorException.unauthorized({
    super.title = "Este usuario no tiene acceso a esta pantalla",
    super.message = "Contacta a tu administrador para solicitar acceso",
    super.data,
    super.type = HttpExceptions.unauthorized,
  });

  /// The constructor for the expired token exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras]
  /// values that can be used to manage the exception.
  ClientErrorException.expiredToken({
    super.title = "Sesión caducada",
    super.message = "El token de autorización esta expirado",
    super.data,
    super.type = HttpExceptions.expiredToken,
  });

  /// The constructor for the Bad Request exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras]
  /// values that can be used to manage the exception.
  ClientErrorException.badRequest({
    super.title = "Petición incorrecta",
    super.message = "Los parámetros enviados al servidor son incorrectos",
    super.data,
    super.type = HttpExceptions.badRequest,
  });

  /// The constructor for the cancel exception.
  ClientErrorException.cancelRequest({
    super.title = "Petición cancelada",
    super.message = "La petición fue cancelada por el usuario",
    super.data,
    super.type = HttpExceptions.cancelRequest,
  });
}
