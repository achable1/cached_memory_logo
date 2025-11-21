import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../cubit_states/state_mixin.dart";
import "../errors/failure.dart";

/// A widget that loads the state of a [StateStreamable] and shows different
/// widgets based on the state.
class CubitWidgetStateLoader<T extends StateStreamable<StateMixin<B>>, B>
    extends StatelessWidget {
  /// A widget that loads the state of a [StateStreamable] and shows different
  /// widgets based on the state.
  const CubitWidgetStateLoader({
    required this.onSuccess,
    this.onLoading,
    this.onFailure,
    this.onEmpty,
    this.onInitial,
    super.key,
  });

  /// The [Widget] to show when the state is [WidgetStatus.loading]
  ///
  /// If not provided, a [CircularProgressIndicator.adaptive()] will be shown
  final Widget? onLoading;

  /// The [Widget] to show when the state is [WidgetStatus.success]
  final Widget Function(B data) onSuccess;

  /// The [Widget] to show when the state is [WidgetStatus.failure]
  ///
  /// If not provided, a [Text] with the error message will be shown
  final Widget Function(Failure failure)? onFailure;

  /// The [Widget] to show when the state is [WidgetStatus.empty]
  ///
  /// If not provided, a [Text] with the message "No data found" will be shown
  final Widget? onEmpty;

  /// The [Widget] to show when the state is [WidgetStatus.initial]
  final Widget? onInitial;

  @override
  Widget build(BuildContext context) => BlocBuilder<T, StateMixin<B>>(
        builder: (context, state) {
          switch (state.status) {
            case WidgetStatus.initial:
              return onInitial ?? const SizedBox.shrink();
            case WidgetStatus.loading:
              return Center(
                child: onLoading ?? const CircularProgressIndicator.adaptive(),
              );
            case WidgetStatus.success:
              return onSuccess(state.data as B);
            case WidgetStatus.failure:
              return onFailure?.call(state.failure!) ??
                  Text(state.failure?.title ?? "Ocurrió un error inesperado");
            case WidgetStatus.empty:
              return onEmpty ?? const Text("No hay información disponible");
          }
        },
      );
}
