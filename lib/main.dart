import 'package:flutter/material.dart';
import 'package:prasad/utils/providers/color_scheme_provider.dart';
import 'package:prasad/utils/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ColorSchemeProvider())],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.from(
        colorScheme: Provider.of<ColorSchemeProvider>(
          context,
        ).currentColorScheme,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
