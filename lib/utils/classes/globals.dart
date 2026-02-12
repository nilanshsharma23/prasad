import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:prasad/utils/classes/language_object.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Globals {
  static SupabaseClient supabase = Supabase.instance.client;
  static User? currentUser;
  static LocationData? currentLocation;
  static String currentLocale = 'en';
  static int currentColorScheme = 0;
  static List<LanguageObject> supportedLanguages = [
    LanguageObject(locale: Locale('en'), language: "English"),
    LanguageObject(locale: Locale('hi'), language: 'हिंदी'),
  ];
  static String? currentFcmToken;
}
