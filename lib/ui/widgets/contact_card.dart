import 'package:flutter/material.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class ContactCard extends StatelessWidget {
  final String leading;
  final String name;
  final String phone;
  final void Function()? onFavButtonPressed;
  final IconData favIcon;
  final void Function()? onCallButtonPressed;

  const ContactCard({
    super.key,
    required this.leading,
    required this.name,
    required this.phone,
    this.onFavButtonPressed,
    required this.favIcon,
    this.onCallButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsetsGeometry.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),

        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            leading,
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),

        subtitle: Text(phone),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onFavButtonPressed,
              icon: Icon(favIcon, color: colorScheme.primary),
            ),
            IconButton(
              onPressed: onCallButtonPressed,
              icon: const Icon(Icons.call),
              color: colorScheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
