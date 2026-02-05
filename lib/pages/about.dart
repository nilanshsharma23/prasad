import 'package:flutter/material.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/widgets/about_section.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(32),
          child: Column(
            spacing: 32,
            children: [
              AboutSection(
                title: AppLocalizations.of(context)!.prasad,
                subtitle: AppLocalizations.of(context)!.prasadDescription,
              ),
              AboutSection(
                title: AppLocalizations.of(context)!.findFreeFood,
                subtitle: AppLocalizations.of(context)!.findFreeFoodDescription,
              ),
              AboutSection(
                title: AppLocalizations.of(context)!.hostABhandara,
                subtitle: AppLocalizations.of(
                  context,
                )!.hostABhandaraAboutDescription,
              ),
              AboutSection(
                title: AppLocalizations.of(context)!.whyPrasad,
                subtitle: AppLocalizations.of(context)!.whyPrasadDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
