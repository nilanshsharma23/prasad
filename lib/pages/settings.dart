import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/color_schemes.dart';
import 'package:prasad/utils/enums/themes_enum.dart';
import 'package:prasad/utils/functions/delete_account.dart';
import 'package:prasad/utils/providers/color_scheme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                DropdownMenu(
                  dropdownMenuEntries: Themes.entries,
                  initialSelection: Themes.values[Globals.currentColorScheme],
                  label: Text(AppLocalizations.of(context)!.theme),
                  inputDecorationTheme: InputDecorationTheme(
                    border: InputBorder.none,
                  ),
                  onSelected: (value) async {
                    final ColorSchemeProvider colorSchemeProvider =
                        Provider.of<ColorSchemeProvider>(
                          context,
                          listen: false,
                        );

                    colorSchemeProvider.setColorScheme(
                      ColorSchemes.colorSchemeList[value!.index],
                    );

                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    prefs.setInt('current_color_scheme', value.index);
                  },
                  width: double.infinity,
                ),
                if (Globals.supabase.auth.currentUser != null)
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        await Globals.supabase.auth.signOut();

                        setState(() {
                          loading = false;
                        });

                        if (context.mounted) {
                          context.go('/');
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.signOut,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                if (Globals.supabase.auth.currentUser != null)
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        await deleteAccount(
                          uid: Globals.supabase.auth.currentUser!.id,
                        );

                        setState(() {
                          loading = false;
                        });

                        if (context.mounted) {
                          context.go('/');
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.deleteAccount,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (loading)
            SpinKitThreeBounce(
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
        ],
      ),
    );
  }
}
