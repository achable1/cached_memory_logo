import "dart:async";

import "package:dio/dio.dart";
import "package:dio/io.dart";
import "package:flutter/foundation.dart";
import "package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart";

import "../errors/connection/http_call_exception.dart";
import "../extensions/num_extension.dart";
import "../services/connection/network_info.dart";

/// Adapter for the Dio client
///
/// This adapter is used to create a Dio client with the necessary
/// configurations for the application. It also includes the necessary
/// error handling for the application.
class DioAdapter extends DioForNative {
  /// Adapter for the Dio client
  ///
  /// This adapter is used to create a Dio client with the necessary
  /// configurations for the application. It also includes the necessary
  /// error handling for the application.
  DioAdapter({
    required this.internetInfo,
    this.receiveTimeout,
    this.connectTimeout,
    this.sendTimeout,
  }) {
    _initializeAdapter();
  }

  /// Information about the internet connection
  final NetworkInfo internetInfo;

  /// The timeout for the receive operation
  final Duration? receiveTimeout;

  /// The timeout for the connect operation
  final Duration? connectTimeout;

  /// The timeout for the send operation
  final Duration? sendTimeout;

  void _initializeAdapter() {
    options = BaseOptions(
      sendTimeout: sendTimeout,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      contentType: "application/x-www-form-urlencoded",
      responseType: ResponseType.json,
    );

    interceptors
      ..add(
        PrettyDioLogger(
          requestHeader: false,
          queryParameters: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          showProcessingTime: false,
          showCUrl: false,
          canShowLog: kDebugMode,
        ),
      )
      ..add(
        InterceptorsWrapper(
          onRequest: onRequestMethod,
          onResponse: onResponseMethod,
          onError: onErrorMethod,
        ),
      );
  }

  /// Handles the request prior to being sent
  FutureOr<void> onRequestMethod(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async =>
      handler.next(options);

  /// Handles the response prior to being returned
  FutureOr<void> onResponseMethod(
    Response response,
    ResponseInterceptorHandler handler,
  ) async =>
      handler.next(response);

  /// Handles the error prior to being thrown
  FutureOr<void> onErrorMethod(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    HttpCallException? errorObject;
    switch (error.type) {
      case DioExceptionType.connectionError:
        errorObject = await internetInfo.isConnected
            ? ConnectionErrorException.serverDown()
            : ConnectionErrorException.clientOffline();

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorObject = await internetInfo.isConnected
            ? ConnectionErrorException.serverDown()
            : ConnectionErrorException.clientOffline();

      case DioExceptionType.badResponse:
        final statusCode = error.response!.statusCode!;

        if (statusCode.isBetween(300, 499)) {
          final errorMessage = error.response?.data["Message"] != null
              ? (error.response!.data["Message"] as String).trim()
              : "Los parámetros enviados al servidor son incorrectos";

          errorObject = statusCode.isBetween(401, 403)
              ? ClientErrorException.unauthorized(data: error.response?.data)
              : ClientErrorException.badRequest(
                  message: errorMessage,
                  data: error.response?.data,
                );
        } else if (statusCode.isBetween(500, 599)) {
          final String? generalMessage =
              error.response?.data["ExceptionMessage"] as String?;

          final Map<String, dynamic>? innerException =
              error.response?.data["InnerException"];
          final String? innerMessage =
              innerException?["ExceptionMessage"] as String?;

          errorObject = ServerErrorException(
            title: "Error del servidor",
            message: innerMessage ??
                generalMessage ??
                "Estamos trabajando en ello lo más rápido posible",
            data: error.response?.data,
          );
        } else {
          errorObject = ClientErrorException.badRequest();
        }
      case DioExceptionType.cancel:
        errorObject = ClientErrorException.cancelRequest();
      case DioExceptionType.badCertificate:
        errorObject = ServerErrorException.badCertificate();
      case DioExceptionType.unknown:
        errorObject = await internetInfo.isConnected
            ? ConnectionErrorException.serverDown()
            : ConnectionErrorException.clientOffline();
    }

    final customError = error.copyWith(
      error: errorObject,
    );

    handler.reject(customError);

    return;
  }
}
