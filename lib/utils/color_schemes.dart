import 'package:flutter/material.dart';

class ColorSchemes {
  // Light Mode Colors
  static const Color lightPrimary = Color(0xFFFF9933);
  static const Color lightSecondary = Color(0xFF138808);
  static const Color lightAccent = Color(0xFFFDB813);
  static const Color lightBackground = Color(0xFFF5F1E8);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF5C4033);
  static const Color lightTextSecondary = Color(0xFF8B7355);
  static const Color lightBorder = Color(0xFFE5E5E5);

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFFD97706);
  static const Color darkSecondary = Color(0xFF059669);
  static const Color darkAccent = Color(0xFFF59E0B);
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkCardBackground = Color(0xFF262626);
  static const Color darkTextPrimary = Color(0xFFFEF3C7);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkBorder = Color(0xFF404040);

  static ColorScheme lightColors = ColorScheme.light(
    primary: lightPrimary,
    secondary: lightSecondary,
    tertiary: lightAccent,
    surface: lightBackground,
    error: Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: lightTextSecondary,
    onSurface: lightTextPrimary,
    outline: lightBorder,
    surfaceContainer: lightCardBackground,
  );

  static ColorScheme darkColors = ColorScheme.dark(
    primary: darkPrimary,
    secondary: darkSecondary,
    tertiary: darkAccent,
    surface: darkBackground,
    error: Color(0xFFCF6679),
    onPrimary: Color(0xFF1A1A1A),
    onSecondary: darkTextSecondary,
    onSurface: darkTextPrimary,
    outline: darkBorder,
    surfaceContainer: darkCardBackground,
  );
}
