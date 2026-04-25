import 'package:flutter/material.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class FormInputTheme {
  static InputDecorationTheme theme(ColorScheme scheme) {
    return InputDecorationTheme(
      errorMaxLines: 3,

      prefixIconColor: scheme.onSurfaceVariant,
      suffixIconColor: scheme.onSurfaceVariant,

      labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      hintStyle: TextStyle(color: scheme.onSurfaceVariant),

      floatingLabelStyle: TextStyle(color: scheme.primary),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        borderSide: BorderSide(color: scheme.outline),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        borderSide: BorderSide(color: scheme.outline),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        borderSide: BorderSide(color: scheme.primary),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        borderSide: BorderSide(color: scheme.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        borderSide: BorderSide(color: scheme.error),
      ),
    );
  }
}
