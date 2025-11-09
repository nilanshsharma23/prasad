import 'package:flutter/material.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    super.key,
    required this.primaryColor,
    required this.status,
    required this.subtext,
  });

  final Color primaryColor;
  final String status;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: 160,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtext,
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
