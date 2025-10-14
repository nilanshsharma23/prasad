import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:prasad/utils/color_schemes.dart';
import 'package:prasad/utils/providers/color_scheme_provider.dart';
import 'package:provider/provider.dart';

typedef ThemeEntry = DropdownMenuEntry<Theme>;

enum Theme {
  systemDefault("System Default"),
  light("Light"),
  dark("Dark");

  const Theme(this.label);
  final String label;

  static final List<ThemeEntry> entries = UnmodifiableListView<ThemeEntry>(
    values.map<ThemeEntry>(
      (Theme theme) => ThemeEntry(label: theme.label, value: theme),
    ),
  );
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            DropdownMenu(
              dropdownMenuEntries: Theme.entries,
              initialSelection: Theme.systemDefault,
              label: Text("Theme"),
              inputDecorationTheme: InputDecorationTheme(
                border: InputBorder.none,
              ),
              onSelected: (value) {
                final ColorSchemeProvider colorSchemeProvider =
                    Provider.of<ColorSchemeProvider>(context, listen: false);

                colorSchemeProvider.setColorScheme(
                  ColorSchemes.colorSchemeList[value!.index],
                );
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
