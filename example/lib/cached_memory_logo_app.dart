import "package:flutter/material.dart";
import "package:flutter_flavor/flutter_flavor.dart";

import "core/constants/theme/material_theme.dart";
import "core/constants/theme/util.dart";
import "core/routes/app_router.dart";

final _appRouter = AppRouter(); 

/// [CachedMemoryLogoApp] is the entry point of the application.
class CachedMemoryLogoApp extends StatelessWidget {
  /// [CachedMemoryLogoApp] is the entry point of the application.
  const CachedMemoryLogoApp({super.key});

  @override
  Widget build(BuildContext context) =>
     FlavorBanner(
      child: MaterialApp.router(
        title: "CachedMemoryLogo",
        debugShowCheckedModeBanner: false,

        //Theming
        themeMode: ThemeMode.system,
            theme: MaterialTheme(createTextTheme(context, "Poppins", "Poppins"),)
                .light(),
            darkTheme:
                MaterialTheme(createTextTheme(context, "Poppins", "Poppins"),)
                    .dark(),


        routerConfig: _appRouter.config(),
      ),
    );
}
