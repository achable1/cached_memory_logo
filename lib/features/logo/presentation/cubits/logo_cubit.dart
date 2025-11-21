import "dart:convert";
import "dart:typed_data";

import "package:fpdart/fpdart.dart";
import "package:get_it/get_it.dart";

import "../../../../core/errors/failure.dart";
import "../../business/repositories/logo_repository.dart";
import "../../business/use_cases/get_base_64_logo.dart";
import "../../data/models/params/logo_params.dart";
import "get_info_cubit.dart";

/// A cubit that manages the state of the logo.
class LogoCubit extends GetInfoCubit<Uint8List> {
  /// Creates a [LogoCubit].
  LogoCubit({
    required this.params,
  });

  /// The parameters for the logo.
  final LogoParams params;

  @override
  Future<Either<Failure, Uint8List>> callUseCase() async {
    try {
      final result = await GetBase64Logo(
        logoRepository: GetIt.I.get<LogoRepository>(),
      ).call(
        params: params,
      );
      return result.fold(
        Left.new,
        (r) {
          try {
            return Right(
              base64Decode(r),
            );
          } catch (e) {
            return Left(
              AppFailure.unexpected(
                "El string no es un formato válido de base64",
              ),
            );
          }
        },
      );
    } catch (e) {
      return Left(AppFailure.unexpected(e.toString()));
    }
  }
}
