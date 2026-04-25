import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';

class DefaultFloatingActionButtonTheme {
  static FloatingActionButtonThemeData theme(ColorScheme scheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),

      extendedTextStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: scheme.onPrimary,
      ),
    );
  }
}
