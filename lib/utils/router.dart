import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/pages/about.dart';
import 'package:prasad/pages/home.dart';
import 'package:prasad/pages/host.dart';
import 'package:prasad/pages/introduction.dart';
import 'package:prasad/pages/listing_created.dart';
import 'package:prasad/pages/my_listings.dart';
import 'package:prasad/pages/profile.dart';
import 'package:prasad/pages/settings.dart';
import 'package:prasad/pages/sign_in.dart';
import 'package:prasad/utils/widgets/navigation/navigation_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/introduction',
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return NavigationScaffold(child: child);
      },
      routes: [
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: '/',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: '/host',
          builder: (context, state) => HostPage(),
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: '/my-listings',
          builder: (context, state) => MyListingsPage(),
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: '/profile',
          builder: (context, state) => ProfilePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/listing-created',
      builder: (context, state) => ListingCreatedPage(),
    ),
    GoRoute(
      path: '/introduction',
      builder: (context, state) => IntroductionPage(),
      redirect: (context, state) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (prefs.getBool("app_opened") == true) {
          return '/';
        }

        return null;
      },
    ),
    GoRoute(path: '/settings', builder: (context, state) => SettingsPage()),
    GoRoute(path: '/sign-in', builder: (context, state) => SignInPage()),
    GoRoute(path: '/about', builder: (context, state) => AboutPage()),
  ],
);
