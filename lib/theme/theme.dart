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
  hintColor: const Color(0xFFBABABA),
  fontFamily: 'M PLUS Rounded 1c',
  fontFamilyFallback: [
    if (Platform.isAndroid) 'Roboto',
    if (Platform.isAndroid) 'Source Sans Pro',
    if (Platform.isIOS) '.SF UI Display',
    if (Platform.isIOS) '.SF UI Text',
    if (Platform.isIOS) 'PingFang SC',
    if (Platform.isIOS) 'Heiti SC'
  ],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 4,
    titleTextStyle: TextStyle(
        color: fontColour,
        fontSize: 16,
        fontWeight: FontWeight.w800,
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
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: 1
    ),
    titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1
    ),
    titleSmall: TextStyle(
        color: fontColour,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1
    ),
    headlineLarge: TextStyle(
      color: fontColour,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: 1
    ),
    headlineMedium: TextStyle(
      color: fontColour,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 1
    ),
    bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 1
    ),
    bodyMedium: TextStyle(
      color: fontColour,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 1
    ),
    bodySmall: TextStyle(
      color: fontColour,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.12,
    ),
    labelMedium: TextStyle(
        color: Color(0xFF727272),
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 1
    ),
    labelSmall: TextStyle(
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
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Color(0xFF7E7E7E);
        }
        return primaryColor;
      }),
      shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24)
      )),
      textStyle: MaterialStatePropertyAll(
        TextStyle(
          color: fontColour,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.6
        )
      ),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
      minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
      fixedSize: MaterialStatePropertyAll(Size.fromHeight(56)),
      alignment: Alignment.center
    )
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Color(0xFF7E7E7E);
        } else if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return Colors.transparent;
      }),
      shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      )),
      side: MaterialStatePropertyAll(BorderSide(width: 2)),
      textStyle: MaterialStatePropertyAll(
          TextStyle(
              color: fontColour,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.6
          )
      ),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
      minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
      fixedSize: MaterialStatePropertyAll(Size.fromHeight(56)),
      alignment: Alignment.center
    )
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      )),
      textStyle: MaterialStatePropertyAll(
        TextStyle(
          color: primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.6
        )
      ),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
      minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
      fixedSize: MaterialStatePropertyAll(Size.fromHeight(56)),
      alignment: Alignment.center
    )
  ),
  searchBarTheme: SearchBarThemeData(
    elevation: MaterialStatePropertyAll(0),
    shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24)
    )),
    side: MaterialStatePropertyAll(BorderSide(width: 2)),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    elevation: 0,
    modalBarrierColor: Colors.white.withOpacity(0.6)
  ),
  dialogTheme: DialogTheme(
    elevation: 0
  ),
);
