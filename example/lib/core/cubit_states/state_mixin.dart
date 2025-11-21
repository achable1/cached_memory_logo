import "../errors/failure.dart";

/// [StateMixin] is a class that represents the state of a widget.
///
/// It can be in one of the following states:
/// - [WidgetStatus.initial]: The initial state of the widget.
/// - [WidgetStatus.loading]: The widget is loading data.
/// - [WidgetStatus.success]: The widget has successfully loaded data.
/// - [WidgetStatus.failure]: The widget has failed to load data.
/// - [WidgetStatus.empty]: The widget has loaded data, but it is empty.
class StateMixin<T> {
  /// [StateMixin] is a class that represents the state of a widget.
  ///
  /// It can be in one of the following states:
  /// - [WidgetStatus.initial]: The initial state of the widget.
  /// - [WidgetStatus.loading]: The widget is loading data.
  /// - [WidgetStatus.success]: The widget has successfully loaded data.
  /// - [WidgetStatus.failure]: The widget has failed to load data.
  /// - [WidgetStatus.empty]: The widget has loaded data, but it is empty.
  StateMixin({
    required this.status,
    this.data,
    this.failure,
  });

  /// Returns a new [StateMixin] with the status set to [WidgetStatus.initial].
  factory StateMixin.initial() => StateMixin(status: WidgetStatus.initial);

  /// Returns a new [StateMixin] with the status set to [WidgetStatus.loading].
  factory StateMixin.loading() => StateMixin(status: WidgetStatus.loading);

  /// Returns a new [StateMixin] with the status set to [WidgetStatus.success].
  factory StateMixin.success(T data) {
    bool isEmpty = false;
    if (data is Iterable) {
      isEmpty = data.isEmpty;
    } else if (data is String) {
      isEmpty = data.isEmpty;
    } else if (data is Map) {
      isEmpty = data.isEmpty;
    } else if (data is List) {
      isEmpty = data.isEmpty;
    } else if (data is Set) {
      isEmpty = data.isEmpty;
    } else {
      isEmpty = false;
    }

    return StateMixin(
      data: data,
      status: isEmpty ? WidgetStatus.empty : WidgetStatus.success,
    );
  }

  /// Returns a new [StateMixin] with the status set to [WidgetStatus.failure].
  factory StateMixin.failure(Failure failure) => StateMixin(
        failure: failure,
        status: WidgetStatus.failure,
      );

  /// The data of the widget.
  T? data;

  /// The failure of the widget.
  Failure? failure;

  /// The status of the widget.
  WidgetStatus status;

  @override
  bool operator ==(covariant StateMixin<T> other) {
    if (identical(this, other)) {
      return true;
    }

    return other.data == data &&
        other.failure == failure &&
        other.status == status;
  }

  @override
  int get hashCode => data.hashCode ^ failure.hashCode ^ status.hashCode;
}

/// The status of the widget.
enum WidgetStatus {
  /// The initial state of the widget.
  initial,

  /// The widget is loading data.
  loading,

  /// The widget has successfully loaded data.
  success,

  /// The widget has failed to load data.
  failure,

  /// The widget has loaded data, but it is empty.
  empty,
}
