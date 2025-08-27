import "package:auto_route/auto_route.dart";
import "package:cached_memory_logo/features/logo/presentation/widgets/cached_memory_logo.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../cubits/home_cubit.dart";

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
        body: BlocProvider(
          create: (context) => HomeCubit(),
          child: const Column(
            children: [
              CachedMemoryLogo(
                path: "logos/oxxo.png",
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      );
}
