import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: TreeTalesApp()));
}

class TreeTalesApp extends StatelessWidget {
  const TreeTalesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TreeTales',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
