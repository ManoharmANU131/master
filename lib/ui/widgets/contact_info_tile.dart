import 'package:flutter/material.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class ContactInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const ContactInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
      ),
      child: Row(
        spacing: AppSizes.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.xs,
              children: [
                Text(
                  title,
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
