import 'package:flutter/material.dart';
import 'package:prasad/utils/color_schemes.dart';

class ColorSchemeProvider extends ChangeNotifier {
  ColorScheme currentColorScheme = ColorSchemes.darkColors;

  setColorScheme(ColorScheme colorScheme) {
    currentColorScheme = colorScheme;
    notifyListeners();
  }
}
