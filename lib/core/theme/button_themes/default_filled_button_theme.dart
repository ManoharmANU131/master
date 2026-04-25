import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class DefaultFilledButtonTheme {
  static FilledButtonThemeData theme(ColorScheme scheme) {
    return FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(scheme.primary),
        foregroundColor: WidgetStatePropertyAll(scheme.onPrimary),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(
              AppSizes.borderRadiusMd,
            ),
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
