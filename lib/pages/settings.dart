import 'package:flutter/material.dart';
import 'package:prasad/utils/color_schemes.dart';
import 'package:prasad/utils/enums/themes_enum.dart';
import 'package:prasad/utils/providers/color_scheme_provider.dart';
import 'package:provider/provider.dart';

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
              dropdownMenuEntries: Themes.entries,
              initialSelection: Themes.systemDefault,
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
