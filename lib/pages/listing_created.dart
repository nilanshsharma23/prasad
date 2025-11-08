import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/l10n/app_localizations.dart';

class ListingCreatedPage extends StatelessWidget {
  const ListingCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(32),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.success,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text(
                AppLocalizations.of(context)!.bhandaraCreated,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Icon(Icons.check, size: 128),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
