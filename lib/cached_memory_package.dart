import "core/config/dependency_injection.dart";
import "core/config/environment_config.dart";

/// Base class for Cached Memory Logo
class CachedMemoryPackage {
  /// Initializes the Cached Memory Logo package with the given fetchUrl.
  static Future<void> init({required String fetchUrl}) async {
    await DependencyInjection.init();
    EnvironmentConfig.fetchUrl = fetchUrl;
  }
}
