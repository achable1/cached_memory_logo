import "package:cached_memory_logo/core/config/dependency_injection.dart";
import "package:cached_memory_logo/core/config/environment_config.dart";
import "package:flutter/material.dart";

import "cached_memory_logo_app.dart";

void main() async {
  EnvironmentConfig.init(
    flavor: Flavor.production,
  );

  await DependencyInjection.init();

  runApp(const CachedMemoryLogoApp());
}
