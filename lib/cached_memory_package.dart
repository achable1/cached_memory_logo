import "core/config/cached_memory_logo_dependency_injection.dart";
import "package_init_params.dart";

/// Base class for Cached Memory Logo
class CachedMemoryPackage {
  /// Initializes the Cached Memory Logo package with the necessary parameters
  static Future<void> init({
    required PackageInitParams params,
  }) async {
    await CachedMemoryLogoDependencyInjection.init(
      params: params,
    );
  }
}
