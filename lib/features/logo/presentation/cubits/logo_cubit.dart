import "dart:typed_data";

import "package:fpdart/fpdart.dart";

import "../../../../core/errors/failure.dart";
import "get_info_cubit.dart";

/// A cubit that manages the state of the logo.
class LogoCubit extends GetInfoCubit<Uint8List> {
  @override
  Future<Either<Failure, Uint8List>> callUseCase() {
    // TODO: implement callUseCase
    throw UnimplementedError();
  }

}
