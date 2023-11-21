import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'const.dart';

final themeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  disabledColor: disabledColor,
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  dividerColor: dividerColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  hintColor: const Color(0xFFBABABA),
  fontFamily: Platform.isAndroid ? 'Roboto' : null,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 4,
    titleTextStyle: TextStyle(
        color: fontColour,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1
    ),
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: fontColour),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    )
  ),
  textTheme: TextTheme(
    titleLarge: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 1
    ),
    titleMedium: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1
    ),
    titleSmall: const TextStyle(
        color: fontColour,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1
    ),
    headlineLarge: const TextStyle(
      color: fontColour,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: 1
    ),
    headlineMedium: const TextStyle(
      color: fontColour,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 1
    ),
    bodyLarge: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 1
    ),
    bodyMedium: const TextStyle(
      color: fontColour,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 1
    ),
    bodySmall: const TextStyle(
      color: fontColour,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.12,
    ),
    labelSmall: const TextStyle(
        color: Color(0xA8111111),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 1
    )
  ),
  buttonTheme: const ButtonThemeData(
    shape: ContinuousRectangleBorder(),
    padding: EdgeInsets.zero,
    height: 60,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      )),
      textStyle: MaterialStatePropertyAll(TextStyle(color: fontColour)),
      alignment: Alignment.center
    )
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ))
    )
  ),
  bottomSheetTheme: BottomSheetThemeData(
    elevation: 0
  ),
  dialogTheme: DialogTheme(
    elevation: 0
  )
);
