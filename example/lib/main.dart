import "package:cached_memory_logo/cached_memory_package.dart";
import "package:dio/dio.dart";
import "package:flutter/material.dart";

import "core/config/environment_config.dart";
import "example_app.dart";

void main() async {
  EnvironmentConfig.init(
    flavor: Flavor.production,
  );

  await CachedMemoryPackage.init(
    dio: Dio(),
    toleranceRange: const Duration(seconds: 1),
  );

  runApp(const ExampleApp());
}
