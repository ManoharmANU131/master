import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_contacts_app/app/router/route_path.dart';
import 'package:my_contacts_app/ui/layouts/main_shell.dart';
import 'package:my_contacts_app/ui/screens/contact_detail_screen.dart';
import 'package:my_contacts_app/ui/screens/onboarding_screen.dart';
import 'package:my_contacts_app/ui/screens/splash_screen.dart';

class RouteConfig {
  RouteConfig._();

  static final _rootKey = GlobalKey<NavigatorState>();

  static CustomTransitionPage _buildPage(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 300),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.08, 0),
          end: Offset.zero,
        ).animate(fadeAnimation);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: slideAnimation, child: child),
        );
      },
    );
  }

  static final GoRouter router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: RoutePath.splash,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        pageBuilder: (context, state) =>
            _buildPage(state, const SplashScreen()),
      ),

      GoRoute(
        path: RoutePath.onBoarding,
        pageBuilder: (context, state) =>
            _buildPage(state, const OnboardingScreen()),
      ),

      GoRoute(
        path: RoutePath.contact,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const MainShell()),
      ),

      GoRoute(
        path: RoutePath.contactDetail,
        pageBuilder: (context, state) {
          final contactId = state.extra as int;

          return _buildPage(state, ContactDetailsScreen(contactId: contactId));
        },
      ),
    ],
  );
}
