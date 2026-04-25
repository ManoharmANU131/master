import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_contacts_app/app/router/route_path.dart';
import 'package:my_contacts_app/core/session/session_manager.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    await _controller.forward();

    await Future.delayed(const Duration(milliseconds: 800));

    final completed = await SessionManager.hasCompletedOnboarding();

    if (!mounted) return;

    if (completed) {
      context.go(RoutePath.contact);
    } else {
      context.go(RoutePath.onBoarding);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer,
              colorScheme.secondaryContainer,
              colorScheme.tertiaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSizes.md,
                children: [
                  Hero(
                    tag: "contact_icon",
                    child: Icon(
                      Icons.contacts,
                      size: 120,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    "My Contacts",
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
