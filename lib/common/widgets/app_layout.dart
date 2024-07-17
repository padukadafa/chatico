import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final Brightness? brightness;
  final Brightness? systemNavbarBrightness;
  final Color? surfaceColor;
  const AppLayout({
    super.key,
    required this.child,
    this.brightness,
    this.surfaceColor,
    this.systemNavbarBrightness,
  });

  @override
  Widget build(BuildContext context) {
    final statusBrightness = brightness ??
        (Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light);
    final surface = surfaceColor ?? Theme.of(context).colorScheme.surfaceBright;
    final navbarBrightness = systemNavbarBrightness ??
        (Theme.of(context).brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: surface,
        systemNavigationBarColor: Theme.of(context).colorScheme.surfaceBright,
        systemNavigationBarIconBrightness: navbarBrightness,
        statusBarBrightness: statusBrightness,
        statusBarIconBrightness: statusBrightness,
      ),
      child: SafeArea(child: child),
    );
  }
}
