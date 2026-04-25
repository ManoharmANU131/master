import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextTheme textTheme(ColorScheme scheme) {
    final base = _baseTextTheme(scheme);

    final poppins = GoogleFonts.poppinsTextTheme(base);
    final inter = GoogleFonts.interTextTheme(base);
    return TextTheme(
      displayLarge: poppins.displayLarge,
      displayMedium: poppins.displayMedium,
      displaySmall: poppins.displaySmall,

      headlineLarge: poppins.headlineLarge,
      headlineMedium: poppins.headlineMedium,
      headlineSmall: poppins.headlineSmall,

      titleLarge: poppins.titleLarge,
      titleMedium: poppins.titleMedium,
      titleSmall: poppins.titleSmall,

      bodyLarge: inter.bodyLarge,
      bodyMedium: inter.bodyMedium,
      bodySmall: inter.bodySmall,

      labelLarge: inter.labelLarge,
      labelMedium: inter.labelMedium,
      labelSmall: inter.labelSmall,
    );
  }

  static TextTheme _baseTextTheme(ColorScheme scheme) {
    return TextTheme(
      displayLarge: _style(59, FontWeight.w500, scheme),
      displayMedium: _style(47, FontWeight.w500, scheme),
      displaySmall: _style(38, FontWeight.w500, scheme),

      headlineLarge: _style(34, FontWeight.w500, scheme),
      headlineMedium: _style(30, FontWeight.w500, scheme),
      headlineSmall: _style(26, FontWeight.w500, scheme),

      titleLarge: _style(24, FontWeight.w500, scheme),
      titleMedium: _style(18, FontWeight.w500, scheme),
      titleSmall: _style(16, FontWeight.w500, scheme),

      bodyLarge: _style(18, FontWeight.w400, scheme),
      bodyMedium: _style(16, FontWeight.w400, scheme),
      bodySmall: _style(14, FontWeight.w400, scheme),

      labelLarge: _style(16, FontWeight.w500, scheme),
      labelMedium: _style(14, FontWeight.w500, scheme),
      labelSmall: _style(13, FontWeight.w500, scheme),
    );
  }

  static TextStyle _style(double size, FontWeight weight, ColorScheme scheme) {
    return TextStyle(
      inherit: false,
      fontSize: size,
      fontWeight: weight,
      color: scheme.onSurface,
      height: 1.4,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }
}
