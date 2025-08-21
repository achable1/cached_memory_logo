import "dart:typed_data";

import "package:fpdart/fpdart.dart";
import "package:get_it/get_it.dart";

import "../../../../core/errors/failure.dart";
import "../../business/repositories/logo_repository.dart";
import "../../business/use_cases/get_base_64_logo.dart";
import "../../data/models/params/logo_params.dart";
import "get_info_by_value_cubit.dart";

/// A cubit that manages the state of the logo.
class LogoCubit extends GetInfoByValueCubit<Uint8List, LogoParams> {
  @override
  Future<Either<Failure, Uint8List>> callUseCase() {
    GetBase64Logo(
      logoRepository: GetIt.I<LogoRepository>(),
    ).call(params: value ?? LogoParams());

    throw UnimplementedError(
      "The callUseCase method is not implemented in LogoCubit.",
    );

  }

}
