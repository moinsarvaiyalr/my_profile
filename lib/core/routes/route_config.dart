import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_practical/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:flutter_practical/features/profile/presentation/screen/user_profile_screen.dart';
import 'package:flutter_practical/main/defer_init.dart';

import 'route_path.dart';

final class RouteConfig {
  final GoRouter goRouter; // This instance will store route state
  static RouteConfig? _instance;

  factory RouteConfig() {
    _instance ??= RouteConfig._();
    return _instance!;
  }

  RouteConfig._() : goRouter = _router;

  static GoRouter get _router => GoRouter(
        routes: [
          GoRoute(
            path: RoutePath.intialRoute,
            builder: (context, state) => const DeferScreen(),
          ),
          GoRoute(
            path: RoutePath.profile,
            builder: UserProfileScreen.routeBuilder,
          ),
          GoRoute(
            path: RoutePath.editProfile,
            builder: EditProfileScreen.routeBuilder,
          ),
        ],
        errorBuilder: (context, state) => const Scaffold(
          body: Text('Error'),
        ),
      );
}
