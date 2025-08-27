// ignore_for_file: use_setters_to_change_properties

import "package:flutter/material.dart" show debugPrint;

import "core/config/dependency_injection.dart";
import "core/config/environment_config.dart";

/// Base class for Cached Memory Logo
class CachedMemoryPackage {
  /// Initializes the Cached Memory Logo package with the given fetchUrl.
  static Future<void> init({required String fetchUrl}) async {
    debugPrint("Initializing CachedMemoryPackage with fetchUrl: $fetchUrl");
    await DependencyInjection.init();
    EnvironmentConfig.fetchUrl = fetchUrl;
  }
}
