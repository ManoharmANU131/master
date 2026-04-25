import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class ContactDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ContactDialog({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSizes.md),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

      child: Container(
        padding: const EdgeInsets.all(AppSizes.md),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: textTheme.titleLarge),

                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.sm),
              ...children.expand(
                (child) => [child, const SizedBox(height: AppSizes.sm)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
