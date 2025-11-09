import 'package:flutter/material.dart';
import 'package:prasad/utils/classes/globals.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLocale = Globals.currentLocale;

  setCurrentLocale(String locale) {
    currentLocale = locale;
    notifyListeners();
  }
}
