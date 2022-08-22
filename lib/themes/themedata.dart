// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

enum App_Theme { Light, Dark }

class MyAppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: Colors.blue,
      fontFamily: GoogleFonts.varelaRound().fontFamily,
      splashColor: Colors.blue.withOpacity(0.6),
      cardColor: Colors.white,
      brightness: Brightness.light,
      shadowColor: Colors.black38,
      canvasColor: const Color.fromARGB(255, 232, 230, 230),
      // ignore: deprecated_member_use
      accentColor: Colors.black,
      // ignore: deprecated_member_use
      buttonColor: black.withOpacity(0.5),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        shadowColor: Colors.black38,
        elevation: 1,
      ),
      iconTheme: const IconThemeData(
        color: Colors.blue,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      canvasColor: Colors.grey.shade900,
      splashColor: Colors.blue.withOpacity(0.4),
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.varelaRound().fontFamily,
      cardColor: Colors.grey.shade800,
      // ignore: deprecated_member_use
      accentColor: Colors.white,
      // ignore: deprecated_member_use
      buttonColor: Colors.white,
      primaryColor: Colors.blue,
      appBarTheme: AppBarTheme(
        shadowColor: Colors.white12,
        color: Colors.grey.shade800,
      ),
      iconTheme: const IconThemeData(
        color: Colors.blue,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
