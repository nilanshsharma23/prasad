import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void onDestinationSelected(BuildContext context, {required int index}) {
  switch (index) {
    case 0:
      GoRouter.of(context).go('/');
      break;
    case 1:
      GoRouter.of(context).go('/host');
      break;
    case 2:
      GoRouter.of(context).go('/my-listings');
      break;
    case 3:
      GoRouter.of(context).go('/vendors');
      break;
    case 4:
      GoRouter.of(context).go('/profile');
      break;
    default:
  }
}

int calculateSelectedIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.path;

  if (location == '/host') {
    return 1;
  } else if (location == '/my-listings') {
    return 2;
  } else if (location == '/vendors') {
    return 3;
  } else if (location == '/profile') {
    return 4;
  } else {
    return 0;
  }
}
