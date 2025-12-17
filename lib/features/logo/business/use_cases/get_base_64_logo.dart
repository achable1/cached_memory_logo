import "package:fpdart/fpdart.dart";

import "../../../../core/constants/classes/use_case.dart";
import "../../../../core/errors/failure.dart";
import "../../../../core/services/logger/logger_service.dart";
import "../../data/models/params/logo_params.dart";
import "../repositories/logo_repository.dart";

/// Use case for getting the base64 logo, first part of the flow
class GetBase64Logo implements UseCaseAsync<String, LogoParams> {
  /// Constructor for [GetBase64Logo]
  GetBase64Logo({required this.logoRepository});

  /// Repository for getting logo information
  final LogoRepository logoRepository;

  /// Logger
  Logger get logger => getLogger("GetBase64Logo");

  @override
  Future<Either<Failure, String>> call({
    required LogoParams params,
  }) async {
    logger.i("GetBase64Logo.call - fetching for path=${params.path}");

    if (params.path.isEmpty) {
      return Left(
        AppFailure(
          title: "Error al obtener el logo",
          message: "La ruta del logo no puede estar vacía",
        ),
      );
    }

    final value = await logoRepository.getBase64Image(params: params);
    value.fold(
      (f) => logger.w("GetBase64Logo.call - failure: $f"),
      (s) => logger.i("GetBase64Logo.call - success: ${s.length} bytes"),
    );
    return value.fold(
      (failure) {
        this.failure = failure;
        return Left(failure);
      },
      Right.new,
    );
  }

  @override
  Failure? failure;
}
