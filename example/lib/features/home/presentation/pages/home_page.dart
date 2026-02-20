import "package:auto_route/auto_route.dart";
import "package:cached_memory_logo/features/logo/presentation/widgets/cached_memory_logo.dart";
import "package:flutter/material.dart";

import "../widgets/possible_components.dart";

/// Home page of the application, The logos are displayed in a lazy loading 
/// manner, meaning that they are only loaded when they are visible on the screen. This is achieved 
/// using the [CachedMemoryLogo] widget, which caches the logos in memory and only loads them when 
/// they are needed. This helps to improve the performance of the application and reduce the memory 
/// usage.
@RoutePage()
class HomePage extends StatelessWidget {
  /// Home page of the application, The logos are displayed in a lazy loading 
  /// manner, meaning that they are only loaded when they are visible on the screen. This is achieved 
  /// using the [CachedMemoryLogo] widget, which caches the logos in memory and only loads them when 
  /// they are needed. This helps to improve the performance of the application and reduce the memory 
  /// usage.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: ListView.separated(
            itemCount: 100,
            itemBuilder: (context, index) => possibleComponents[index % possibleComponents.length],
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        );
}
