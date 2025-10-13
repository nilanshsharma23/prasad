import 'package:flutter/material.dart';
import 'package:prasad/utils/router.dart';
import 'package:prasad/utils/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.from(colorScheme: Themes.darkColors),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
