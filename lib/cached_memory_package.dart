import "package:dio/dio.dart";

import "core/config/cached_memory_logo_dependency_injection.dart";

/// Base class for Cached Memory Logo
class CachedMemoryPackage {
  /// Initializes the Cached Memory Logo package with the given fetchUrl.
  static Future<void> init({required String fetchUrl}) async {
    await CachedMemoryLogoDependencyInjection.init(Dio());
  }
}
