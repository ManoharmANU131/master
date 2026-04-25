import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_contacts_app/app/router/route_path.dart';
import 'package:my_contacts_app/core/session/session_manager.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';
import 'package:my_contacts_app/models/on_boarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardData> pages = [
    OnboardData(
      title: "Welcome to My Contacts",
      description: "Manage your contacts easily and securely in one place.",
      icon: Icons.contacts,
    ),
    OnboardData(
      title: "Mark Favorites",
      description: "Quickly access your important contacts anytime.",
      icon: Icons.star,
    ),
    OnboardData(
      title: "Smart Search",
      description: "Find contacts instantly with fast search.",
      icon: Icons.search,
    ),
    OnboardData(
      title: "Get Started",
      description: "Let’s start organizing your contacts efficiently.",
      icon: Icons.rocket_launch,
    ),
  ];

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _skip() {
    _finishOnboarding();
  }

  void _finishOnboarding() async {
    await SessionManager.setOnboardingCompleted(true);
    if (!mounted) return;
    context.go(RoutePath.contact);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer,
              colorScheme.secondaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skip,
                  child: Text("Skip", style: textTheme.labelLarge),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];

                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: "contact_icon",
                            child: Icon(
                              page.icon,
                              size: 120,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: AppSizes.xl),
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: AppSizes.md),
                          Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: textTheme.labelLarge?.copyWith(
                              color: colorScheme.onPrimaryContainer.withValues(
                                alpha: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? colorScheme.primary
                          : colorScheme.primary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.lg),

              Padding(
                padding: const EdgeInsets.all(AppSizes.lg),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.md,
                      ),
                    ),
                    child: Text(
                      _currentPage == pages.length - 1 ? "Get Started" : "Next",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
