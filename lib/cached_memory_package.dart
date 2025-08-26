// ignore_for_file: use_setters_to_change_properties

import "core/config/environment_config.dart";

/// Base class for Cached Memory Logo
class CachedMemoryPackage {
  /// Initializes the Cached Memory Logo package with the given fetchUrl.
  static void init({required String fetchUrl}) {
    EnvironmentConfig.fetchUrl = fetchUrl;
  }
}
