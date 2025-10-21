import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/widgets/barriers/barrier_screen.dart';

class SignInBarrierScreen extends StatelessWidget {
  const SignInBarrierScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Globals.supabase.auth.currentUser != null) {
      return child;
    } else {
      return BarrierScreen(
        barrierText: "You need to sign in to access this feature.",
        buttonText: "Sign In",
        onButtonPressed: () {
          context.go('/sign-in');
        },
      );
    }
  }
}
