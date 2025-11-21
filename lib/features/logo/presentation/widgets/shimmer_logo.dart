import "package:fade_shimmer/fade_shimmer.dart";
import "package:flutter/material.dart";

import "../../../../core/extensions/theme_extension.dart";

/// A widget that displays a shimmering logo effect.
class ShimmerLogo extends StatelessWidget {
  /// Creates a [ShimmerLogo] widget.
  const ShimmerLogo({
    this.height,
    this.width,
    super.key,
  });

  /// The height of the shimmer effect.
  final double? height;

  /// The width of the shimmer effect.
  final double? width;

  @override
  Widget build(BuildContext context) => FittedBox(
    fit: BoxFit.cover,
    child: FadeShimmer(
          height: height ?? 0,
          width: width ?? 0,
          highlightColor: _highlightColor(context),
          baseColor: _baseColor(context),
          fadeTheme: _fadeTheme(context),
        ),
  );

  /// Gets the appropriate fade theme based on current brightness
  FadeTheme _fadeTheme(BuildContext context) =>
      context.colorScheme.brightness == Brightness.dark
          ? FadeTheme.dark
          : FadeTheme.light;

  /// Gets the highlight color for shimmer effect
  Color _highlightColor(BuildContext context) =>
      context.colorScheme.brightness == Brightness.dark
          ? Colors.grey.shade700
          : Colors.grey.shade100;

  /// Gets the base color for shimmer effect
  Color _baseColor(BuildContext context) =>
      context.colorScheme.brightness == Brightness.dark
          ? Colors.grey.shade900
          : Colors.grey.shade300;
}
