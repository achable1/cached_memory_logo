import "package:dio/dio.dart";

import "core/config/cached_memory_logo_dependency_injection.dart";

/// Base class for Cached Memory Logo
class CachedMemoryPackage {
  /// Initializes the Cached Memory Logo package with the provider Dio por remote connection, with an optional
  /// tolerance range (this duration represents the difference between the saved DateTime and the time that you want
  /// to fetch again remote logo data, this automatically sets for 30 days, but, for testing or development flows, you can
  /// set into less time)
  static Future<void> init({
    required Dio dio,
    Duration? toleranceRange,
    bool? isMock,
  }) async {
    await CachedMemoryLogoDependencyInjection.init(
      dio,
      toleranceRange,
      isMock: isMock,
    );
  }
}
