import "../../data/models/objects/logo_object.dart";

/// Cached logo entity for handle the logo table and tolerance range
class CachedLogoEntity {
  /// Cached logo entity for handle the logo table and tolerance range
  CachedLogoEntity({
    required this.data,
    required this.toleranceRange,
  });

  /// Logo table value
  final LogoObject? data;

  /// Tolerance range data
  final Duration toleranceRange;

  /// Method to exposes a bool flag if logo are expired or not
  bool isExpired() =>
      DateTime.tryParse(data?.saved ?? "")
          ?.add(toleranceRange)
          .isBefore(DateTime.now()) ??
      false;
}
