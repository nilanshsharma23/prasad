import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  String selectedLanguage = Globals.supportedLanguages
      .firstWhere(
        (element) => element.locale.languageCode == Globals.currentLocale,
      )
      .language;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: AppLocalizations.of(context)!.selectLanguage,
            image: Image.asset('assets/introduction/language_select.png'),
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(Globals.supportedLanguages.length, (
                index,
              ) {
                return ChoiceChip(
                  label: Text(
                    Globals.supportedLanguages[index].language,
                    style: TextStyle(fontSize: 16),
                  ),
                  selected:
                      selectedLanguage ==
                      Globals.supportedLanguages[index].language,
                  onSelected: (value) async {
                    LanguageProvider languageProvider =
                        Provider.of<LanguageProvider>(context, listen: false);

                    if (value) {
                      languageProvider.setCurrentLocale(
                        Globals.supportedLanguages[index].locale.languageCode,
                      );

                      setState(() {
                        Globals.currentLocale = Globals
                            .supportedLanguages[index]
                            .locale
                            .languageCode;

                        selectedLanguage =
                            Globals.supportedLanguages[index].language;
                      });

                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      prefs.setString(
                        'current_locale',
                        Globals.supportedLanguages[index].locale.languageCode,
                      );
                    }
                  },
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                );
              }),
            ),
          ),
          PageViewModel(
            title: AppLocalizations.of(context)!.findBhandaras,
            body: AppLocalizations.of(context)!.findBhandarasDescription,
            image: Image.asset('assets/introduction/find_bhandaras.png'),
          ),
          PageViewModel(
            title: AppLocalizations.of(context)!.hostABhandara,
            body: AppLocalizations.of(context)!.hostABhandaraDescription,
            image: Image.asset('assets/introduction/host_bhandaras.png'),
          ),
          PageViewModel(
            title: AppLocalizations.of(context)!.allForFree,
            body: AppLocalizations.of(context)!.allForFreeDescription,
            image: Image.asset('assets/introduction/all_for_free.png'),
          ),
        ],
        showSkipButton: true,
        showNextButton: true,
        skip: const Text("Skip"),
        done: const Text("Done"),
        next: const Text("Next"),
        onDone: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("app_opened", true);

          if (context.mounted) {
            context.go('/');
          }
        },
        onSkip: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("app_opened", true);

          if (context.mounted) {
            context.go('/');
          }
        },
        dotsDecorator: DotsDecorator(
          color: Theme.of(context).colorScheme.onSurface,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
