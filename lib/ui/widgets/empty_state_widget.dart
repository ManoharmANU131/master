import 'package:flutter/material.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSizes.xs,
        children: [
          Icon(icon, size: 64),
          Text(title, style: textTheme.titleLarge),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
