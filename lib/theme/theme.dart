import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sona/utils/global/global.dart';

import 'const.dart';

ThemeData get themeData {
  final isCJK = RegExp(r'^(zh|ja|ko|yue)')
      .hasMatch(profile?.locale ?? Platform.localeName);
  return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      disabledColor: disabledColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      dividerColor: dividerColor,
      hintColor: const Color(0xFFBABABA),
      fontFamily: (Platform.isAndroid && isCJK)
          ? 'Source Han Sans'
          : 'M PLUS Rounded 1c',
      fontFamilyFallback: [
        if (Platform.isAndroid && !isCJK) 'M PLUS Rounded 1c',
        if (Platform.isIOS &&
            (profile?.locale ?? Platform.localeName).startsWith('zh'))
          'PingFang SC',
        if (Platform.isIOS &&
            (profile?.locale ?? Platform.localeName).startsWith('ja'))
          'Hiragino Sans',
      ],
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 4,
          titleTextStyle: TextStyle(
              color: fontColour,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 1),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: fontColour),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark)),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              height: 1.5,
              letterSpacing: 0.4),
          titleMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.5,
            letterSpacing: 0.2,
          ),
          titleSmall: TextStyle(
              color: fontColour,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0),
          headlineLarge: TextStyle(
              color: fontColour,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.5,
              letterSpacing: 0),
          headlineMedium: TextStyle(
              color: fontColour,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.5,
              letterSpacing: 0),
          bodyLarge: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0),
          bodyMedium: TextStyle(
              color: fontColour,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0),
          bodySmall: TextStyle(
            color: fontColour,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
            letterSpacing: 0,
          ),
          labelMedium: TextStyle(
              color: Color(0xFF727272),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0),
          labelSmall: TextStyle(
              color: Color(0xA8111111),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0)),
      buttonTheme: const ButtonThemeData(
          shape: ContinuousRectangleBorder(),
          padding: EdgeInsets.zero,
          height: 56,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Color(0xFF7E7E7E);
                }
                return primaryColor;
              }),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              textStyle: MaterialStatePropertyAll(TextStyle(
                  color: fontColour,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0)),
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
              minimumSize: MaterialStatePropertyAll(Size(20, 20)),
              maximumSize: MaterialStatePropertyAll(Size(375, 56)),
              fixedSize: MaterialStatePropertyAll(Size(375, 56)),
              alignment: Alignment.center)),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(primaryColor),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Color(0xFF7E7E7E);
                } else if (states.contains(MaterialState.selected)) {
                  return primaryColor;
                }
                return Colors.transparent;
              }),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              side: MaterialStatePropertyAll(BorderSide(width: 2)),
              textStyle: MaterialStatePropertyAll(TextStyle(
                  color: fontColour,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0)),
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
              minimumSize: MaterialStatePropertyAll(Size(20, 20)),
              maximumSize: MaterialStatePropertyAll(Size(375, 56)),
              fixedSize: MaterialStatePropertyAll(Size(375, 56)),
              alignment: Alignment.center)),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              foregroundColor: MaterialStatePropertyAll(Colors.black),
              textStyle:
                  MaterialStateProperty.resolveWith((Set<MaterialState> state) {
                return TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0);
              }),
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 24)),
              minimumSize: MaterialStatePropertyAll(Size(20, 20)),
              maximumSize: MaterialStatePropertyAll(Size(375, 56)),
              // fixedSize: MaterialStatePropertyAll(Size(375, 56)),
              alignment: Alignment.center)),
      searchBarTheme: SearchBarThemeData(
        elevation: MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        side: MaterialStatePropertyAll(BorderSide(width: 2)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
          elevation: 0, modalBarrierColor: Colors.white.withOpacity(0.7)),
      dialogTheme: DialogThemeData(elevation: 0),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor));
}

/// 赛博酷紫（紫+青为主，冷感科技）暗色主题
ThemeData get nightTheme {
  final isCJK = RegExp(r'^(zh|ja|ko|yue)')
      .hasMatch(profile?.locale ?? Platform.localeName);

  // 色板（暗色）
  const Color ccBackground = Color(0xFF0E0E14); // 近黑深灰
  const Color ccSurface = Color(0xFF12121B); // 深色表面
  const Color ccOnSurface = Color(0xFFEDEDF4); // 主要文字（非纯白）
  const Color ccOnSurfaceVariant = Color(0xFFB5B6C8); // 次级文字
  // 新主色（来源于提供图片的青绿色）
  const Color ccPrimary = Color(0xFF00EED1); // 霓虹青绿主色
  // 次强调：保留冷感紫用于点缀（备用）
  // const Color ccAccentPurple = Color(0xFF7C3AED);
  const Color ccDisabled = Color(0xFF6B7280); // 禁用灰
  const Color ccDivider = Color(0x14FFFFFF); // 8% 白线

  return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: ccPrimary,
      disabledColor: ccDisabled,
      scaffoldBackgroundColor: ccBackground,
      dividerColor: ccDivider,
      hintColor: const Color(0xFF8E8E99),
      fontFamily: (Platform.isAndroid && isCJK)
          ? 'Source Han Sans'
          : 'M PLUS Rounded 1c',
      fontFamilyFallback: [
        if (Platform.isAndroid && !isCJK) 'M PLUS Rounded 1c',
        if (Platform.isIOS &&
            (profile?.locale ?? Platform.localeName).startsWith('zh'))
          'PingFang SC',
        if (Platform.isIOS &&
            (profile?.locale ?? Platform.localeName).startsWith('ja'))
          'Hiragino Sans',
      ],
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 4,
          titleTextStyle: TextStyle(
              color: ccOnSurface,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 1),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: ccOnSurface),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light)),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              color: ccOnSurface,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              height: 1.5,
              letterSpacing: 0.4),
          titleMedium: TextStyle(
            color: ccOnSurface,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.5,
            letterSpacing: 0.2,
          ),
          titleSmall: TextStyle(
              color: ccOnSurfaceVariant,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0),
          headlineLarge: TextStyle(
              color: ccOnSurface,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.5,
              letterSpacing: 0),
          headlineMedium: TextStyle(
              color: ccOnSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.5,
              letterSpacing: 0),
          bodyLarge: TextStyle(
              color: ccOnSurface,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0),
          bodyMedium: TextStyle(
              color: ccOnSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0),
          bodySmall: TextStyle(
            color: ccOnSurfaceVariant,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
            letterSpacing: 0,
          ),
          labelMedium: TextStyle(
              color: Color(0xFF8A8EA0),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0),
          labelSmall: TextStyle(
              color: Color(0xFF7A7E90),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0)),
      buttonTheme: const ButtonThemeData(
          shape: ContinuousRectangleBorder(),
          padding: EdgeInsets.zero,
          height: 56,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return ccDisabled;
                }
                return ccPrimary;
              }),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              textStyle: const MaterialStatePropertyAll(TextStyle(
                  color: ccOnSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0)),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
              minimumSize: const MaterialStatePropertyAll(Size(20, 20)),
              maximumSize: const MaterialStatePropertyAll(Size(375, 56)),
              fixedSize: const MaterialStatePropertyAll(Size(375, 56)),
              alignment: Alignment.center)),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(ccPrimary),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return ccDisabled;
                } else if (states.contains(MaterialState.selected)) {
                  return ccPrimary;
                }
                return Colors.transparent;
              }),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              side: const MaterialStatePropertyAll(
                  BorderSide(width: 2, color: ccPrimary)),
              textStyle: const MaterialStatePropertyAll(TextStyle(
                  color: ccOnSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0)),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
              minimumSize: const MaterialStatePropertyAll(Size(20, 20)),
              maximumSize: const MaterialStatePropertyAll(Size(375, 56)),
              fixedSize: const MaterialStatePropertyAll(Size(375, 56)),
              alignment: Alignment.center)),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              foregroundColor: const MaterialStatePropertyAll(ccOnSurface),
              textStyle:
                  MaterialStateProperty.resolveWith((Set<MaterialState> state) {
                return const TextStyle(
                    color: ccPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0);
              }),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 24)),
              minimumSize: const MaterialStatePropertyAll(Size(20, 20)),
              maximumSize: const MaterialStatePropertyAll(Size(375, 56)),
              alignment: Alignment.center)),
      searchBarTheme: SearchBarThemeData(
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        side: const MaterialStatePropertyAll(
            BorderSide(width: 2, color: ccDivider)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
          elevation: 0, modalBarrierColor: Colors.black.withOpacity(0.6)),
      dialogTheme:
          const DialogThemeData(elevation: 0, backgroundColor: ccSurface),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: ccPrimary));
}
