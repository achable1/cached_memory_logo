import "package:cached_memory_logo/cached_memory_package.dart";
import "package:flutter/material.dart";

import "core/config/dependency_injection.dart";
import "core/config/environment_config.dart";
import "example_app.dart";

void main() async {
  EnvironmentConfig.init(
    flavor: Flavor.production,
  );

  await CachedMemoryPackage.init(fetchUrl: "www.example.com");

  runApp(const ExampleApp());
}
