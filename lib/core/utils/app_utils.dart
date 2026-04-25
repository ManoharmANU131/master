import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppUtils {
  AppUtils._();

  static Future<void> showAppDialog({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }

  static Future<void> showAppAlertDialog({
    required String title,
    required String message,
    required IconData icon,
    required Color iconColor,
    Color? button1Color,
    String? buttonText1,
    String? buttonText2,
    void Function()? buttonAction,
    required BuildContext context,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return AlertDialog(
          icon: CircleAvatar(
            backgroundColor: iconColor.withValues(alpha: 0.2),
            child: Icon(icon, color: iconColor),
          ),
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                buttonText2 ?? "Cancel",
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                buttonAction?.call();
              },
              child: Text(
                buttonText1 ?? "Ok",
                style: textTheme.titleSmall?.copyWith(
                  color: button1Color ?? colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
