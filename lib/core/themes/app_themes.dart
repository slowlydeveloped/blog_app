import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/my_colors.dart';

class AppThemes {
  AppThemes._();
  static final light = ThemeData(
      colorScheme: const ColorScheme.light(secondary: MyColors.primaryColor),
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily);

  static final dark = ThemeData(
      colorScheme: const ColorScheme.light(secondary: MyColors.secondaryColor),
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily);
}
