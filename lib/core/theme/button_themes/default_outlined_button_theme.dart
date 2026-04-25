import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class DefaultOutlinedButtonTheme {
  static OutlinedButtonThemeData theme(ColorScheme scheme) {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(scheme.primary),

        side: WidgetStatePropertyAll(BorderSide(color: scheme.outline)),

        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
        ),

        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
