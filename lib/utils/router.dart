import 'package:go_router/go_router.dart';
import 'package:prasad/pages/home.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => HomePage())],
);
