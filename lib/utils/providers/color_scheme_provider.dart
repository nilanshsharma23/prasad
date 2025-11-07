import 'package:flutter/material.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/color_schemes.dart';

class ColorSchemeProvider extends ChangeNotifier {
  ColorScheme currentColorScheme =
      ColorSchemes.colorSchemeList[Globals.currentColorScheme];

  setColorScheme(ColorScheme colorScheme) {
    currentColorScheme = colorScheme;
    notifyListeners();
  }
}
