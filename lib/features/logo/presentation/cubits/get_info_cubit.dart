import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/cubit_states/state_mixin.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/cubit_extension.dart';

/// Base cubit for getting information from a use case
abstract class GetInfoCubit<T> extends Cubit<StateMixin<T>> {
  /// Base cubit for getting information from a use case
  GetInfoCubit() : super(StateMixin.loading()) {
    getInfo();
  }

  /// Fetch the information from a use case
  Future<Either<Failure, T>> getInfo() async {
    try {
      safeEmit(StateMixin.loading());
      final response = await callUseCase();

      response.fold(
        (failure) => safeEmit(
          StateMixin.failure(
            failure,
          ),
        ),
        (data) => safeEmit(
          StateMixin.success(
            data,
          ),
        ),
      );

      return response;
    } catch (e) {
      final failure = AppFailure.unexpected(e.toString());
      safeEmit(
        StateMixin.failure(
          failure,
        ),
      );

      return Left(failure);
    }
  }

  /// Use case to call
  Future<Either<Failure, T>> callUseCase();
}
