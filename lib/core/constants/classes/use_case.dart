import "package:fpdart/fpdart.dart";

import "../../errors/failure.dart";

/// Usecase abstract class
abstract class BaseUseCase<SuccessType, Params> {
  /// Failure object when the use case fails
  Failure? failure;
}

/// Usecase abstract class for async operations
abstract class UseCaseAsync<SuccessType, Params>
    extends BaseUseCase<SuccessType, Params> {
  /// Usecase abstract class
  UseCaseAsync();

  /// Caller for future methods
  Future<Either<Failure, SuccessType>> call({
    required Params params,
  });
}

/// Usecase abstract class for sync operations
abstract class UseCase<SuccessType, Params>
    extends BaseUseCase<SuccessType, Params> {
  /// Caller for future methods
  Either<Failure, SuccessType> call({
    required Params params,
  });
}
