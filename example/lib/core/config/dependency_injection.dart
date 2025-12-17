import "package:cached_memory_logo/cached_memory_package.dart";
import "package:dio/dio.dart";
import "package:flutter/material.dart";

/// Class to inject the dependencies in the application
class DependencyInjection {
  /// Inject the services in the application
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await CachedMemoryPackage.init(
      dio: Dio(),
    );
  }
}
