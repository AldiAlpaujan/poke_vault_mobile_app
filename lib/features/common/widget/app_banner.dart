import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  final String message;
  final Widget child;
  const AppBanner({super.key, required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Wajib ada untuk Banner
      child: Banner(
        message: message,
        location: BannerLocation.topEnd,
        color: Colors.red.shade700,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.0,
        ),
        child: child,
      ),
    );
  }
}
