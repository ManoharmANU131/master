import 'package:flutter/material.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      child: Column(
        spacing: AppSizes.xs,
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(color: colorScheme.surface),
          ),
        ],
      ),
    );
  }
}
