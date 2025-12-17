import "package:auto_route/auto_route.dart";
import "package:cached_memory_logo/features/logo/presentation/widgets/cached_memory_logo.dart";
import "package:flutter/material.dart";

/// Home page of the application
@RoutePage()
class HomePage extends StatelessWidget {
  /// Home page of the application
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedMemoryLogo(
                path: "logos/costco.png",
                height: 100,
                width: 100,
              ),
              SizedBox(height: 20),
              CachedMemoryLogo(
                path: "logos/costco.png",
                height: 100,
                width: 100,
              ),
              SizedBox(height: 20),
              CachedMemoryLogo(
                path: "logos/another_test.png",
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      );
}
