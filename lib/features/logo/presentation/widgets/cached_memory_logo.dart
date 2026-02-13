import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../core/widgets/cubit_state_mixin_builder.dart";
import "../../business/entities/logo_entity.dart";
import "../../data/models/params/logo_params.dart";
import "../cubits/logo_cubit.dart";
import "shimmer_logo.dart";

/// A widget that displays the cached memory logo.
class CachedMemoryLogo extends StatelessWidget {
  /// Creates a [CachedMemoryLogo] widget.
  const CachedMemoryLogo({
    required this.path,
    this.accessToken,
    super.key,
    this.errorBuilder,
    this.height,
    this.width,
    this.loadingWidget,
    this.fallbackWidget,
  });

  /// The path to the logo image.
  final String path;

  /// The access token to use for the logo request.
  final String? accessToken;

  /// {@macro flutter.widgets.Image.errorBuilder}
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  /// {@macro flutter.widgets.Image.height}
  final double? height;

  /// {@macro flutter.widgets.Image.width}
  final double? width;

  /// Placeholder widget to display while the image is loading.
  final Widget? loadingWidget;

  /// Fallback widget to display in case of an error.
  final Widget? fallbackWidget;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => LogoCubit(
          params: LogoParams(
            path: path,
          )..accessToken = accessToken,
        ),
        child: Builder(
          builder: (context) => CubitWidgetStateLoader<LogoCubit, LogoEntity>(
            onSuccess: (data) {
              if (data.base64Logo != null) {
                return Image.memory(
                  base64Decode(data.base64Logo!),
                  errorBuilder: errorBuilder,
                  height: height,
                  width: width,
                );
              } else if (data.fileLogo != null) {
                return Image.file(
                  data.fileLogo!,
                  errorBuilder: errorBuilder,
                  height: height,
                  width: width,
                );
              }
              return const SizedBox.shrink();
            },
            onFailure: (error) =>
                fallbackWidget ??
                ColoredBox(
                  color: Colors.grey.shade300,
                  child: const SizedBox(),
                ),
            onLoading: loadingWidget ??
                ShimmerLogo(
                  height: height,
                  width: width,
                ),
          ),
        ),
      );
}
