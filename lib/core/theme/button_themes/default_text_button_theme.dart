import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultTextButtonTheme {
  static TextButtonThemeData theme(ColorScheme scheme) {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(scheme.primary),

        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),

        overlayColor: WidgetStatePropertyAll(
          scheme.primary.withValues(alpha: 0.08),
        ),
      ),
    );
  }
}
