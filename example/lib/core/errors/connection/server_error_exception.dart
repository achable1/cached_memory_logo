import "http_call_exception.dart";

/// The Exception that is thrown if a server error ocurrs.
class ServerErrorException extends HttpCallException {
  /// The constructor for the server error general exception.
  ///
  /// Can receive the [response] of the HTTP call, a [message], and [extras
  /// values that can be used to manage the exception.
  ServerErrorException({
    required super.title,
    super.data,
    super.message = "Estamos trabajando en ello lo más rápido posible",
    super.type = HttpExceptions.serverError,
  });

  /// The constructor for the Bad Certificate exception.
  ServerErrorException.badCertificate({
    super.title = "Certificado no válido",
    super.message = "El certificado de seguridad del servidor no es válido",
    super.data,
    super.type = HttpExceptions.badRequest,
  });
}
