import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prasad/utils/providers/color_scheme_provider.dart';
import 'package:prasad/utils/router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.get("SUPABASE_URL"),
    anonKey: dotenv.get('ANON_KEY'),
  );

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
