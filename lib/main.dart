import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/providers/color_scheme_provider.dart';
import 'package:prasad/utils/providers/language_provider.dart';
import 'package:prasad/utils/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.get("SUPABASE_URL"),
    anonKey: dotenv.get('ANON_KEY'),
  );

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.get('FIREBASE_API_KEY'),
      appId: dotenv.get('FIREBASE_APP_ID'),
      messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
      projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    ),
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getInt('current_color_scheme') != null) {
    Globals.currentColorScheme = prefs.getInt('current_color_scheme')!;
  }
  if (prefs.getString('current_locale') != null) {
    Globals.currentLocale = prefs.getString('current_locale')!;
  }

  Globals.supabase.auth.onAuthStateChange.listen((event) async {
    if (event.event == AuthChangeEvent.signedIn) {
      await FirebaseMessaging.instance.requestPermission();

      final String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        await Globals.supabase
            .from('users')
            .update({'fcm_token': fcmToken})
            .eq('user_id', Globals.supabase.auth.currentUser!.id);
      }
    }
  });

  await MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorSchemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
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
      title: "Prasad",
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('hi')],
      locale: Locale(Provider.of<LanguageProvider>(context).currentLocale),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
