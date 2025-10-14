import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:prasad/utils/color_schemes.dart';

class ColorSchemeProvider extends ChangeNotifier {
  ColorScheme currentColorScheme =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark
      ? ColorSchemes.darkColors
      : ColorSchemes.lightColors;

  setColorScheme(ColorScheme colorScheme) {
    currentColorScheme = colorScheme;
    notifyListeners();
  }
}
