import 'package:flutter/material.dart';

class BarrierScreen extends StatelessWidget {
  const BarrierScreen({
    super.key,
    required this.barrierText,
    required this.buttonText,
    required this.onButtonPressed,
  });

  final String barrierText;
  final String buttonText;
  final void Function()? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 32,
        children: [
          Text(
            barrierText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          TextButton(
            onPressed: onButtonPressed,
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
