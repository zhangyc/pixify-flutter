import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'const.dart';

final themeData = ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.inder(
            textStyle: const TextStyle(
                color: fontColour,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1
            )
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: fontColour
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
        )
    ),
    textTheme: TextTheme(
        headlineLarge: GoogleFonts.inder(
            textStyle: const TextStyle(
                color: fontColour,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                letterSpacing: 1
            )
        ),
        bodyMedium: GoogleFonts.inder(
            textStyle: const TextStyle(
                color: fontColour,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 1
            )
        ),
        bodySmall: GoogleFonts.inder(
            textStyle: const TextStyle(
                color: fontColour,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 1
            )
        )
    )
);