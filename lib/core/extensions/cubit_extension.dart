import "package:flutter_bloc/flutter_bloc.dart";

/// Extension for [Cubit] to safely emit a new state.
extension CubitExtension<T> on Cubit<T> {
  /// Safely emits a new state if the cubit is not closed.
  void safeEmit(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}
