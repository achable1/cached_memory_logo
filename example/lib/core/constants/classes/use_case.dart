import "package:fpdart/fpdart.dart";

import "../../errors/failure.dart";

/// Usecase abstract class
abstract class UseCase<SuccessType, Params> {
  /// Caller for future methods
  Future<Either<Failure, SuccessType>> call({
    required Params params,
  }) =>
      Future.value(
        Left(
          AppFailure.unexpected(
            "This type of operation is not supported. Please use call method.",
          ),
        ),
      );
}
