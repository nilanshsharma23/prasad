import 'package:flutter/material.dart';
import 'package:prasad/l10n/app_localizations.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String errorMessage, {
  String title = "Error",
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(title),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.ok),
        ),
      ],
    ),
  );
}
