import 'dart:ui' as ui;

import 'package:intl/locale.dart';

class SonaLocale {
  SonaLocale({
    required this.locale,
    required this.displayName
  });
  final Locale locale;
  final String displayName;

  factory SonaLocale.fromLanguageTag(String languageTag, String displayName) {
    return SonaLocale(
      locale: Locale.parse(languageTag),
      displayName: displayName
    );
  }

  ui.Locale toUILocale() {
    return ui.Locale(locale.languageCode, locale.countryCode);
  }
}

final supportedSonaLocales = [
  SonaLocale.fromLanguageTag('en', 'English (US)'),
  SonaLocale.fromLanguageTag('en-GB', 'English (UK)'),
  SonaLocale.fromLanguageTag('ja', '日本語'),
  SonaLocale.fromLanguageTag('zh-CN', '简体中文'),
  SonaLocale.fromLanguageTag('zh-TW', '繁體中文'),
  SonaLocale.fromLanguageTag('ko', '한국어'),
  SonaLocale.fromLanguageTag('th', 'ภาษาไทย'),
  SonaLocale.fromLanguageTag('pt-PT', 'Português'),
  SonaLocale.fromLanguageTag('pt-BR', 'Português (Brasil)'),
  SonaLocale.fromLanguageTag('es', 'Español'),
  SonaLocale.fromLanguageTag('fr', 'Français'),
  SonaLocale.fromLanguageTag('de', 'Deutsch'),
  SonaLocale.fromLanguageTag('it', 'Italiano'),
  SonaLocale.fromLanguageTag('ru', 'Русский'),
  SonaLocale.fromLanguageTag('yue', '粵語'),
];

Iterable<ui.Locale> supportedLocales = (List.from(supportedSonaLocales)..removeLast()).map<ui.Locale>((sl) => sl.toUILocale());

SonaLocale findMatchedSonaLocale(String languageTag) {
  final locale = Locale.tryParse(languageTag);
  if (locale == null) {
    return supportedSonaLocales.first;
  }
  SonaLocale? firstLanguageCodeMatched;
  for (var l in supportedSonaLocales) {
    if (l.locale.languageCode == locale.languageCode) {
      if (l.locale.countryCode == locale.countryCode) {
        return l;
      } else {
        firstLanguageCodeMatched ??= l;
      }
    }
  }
  return firstLanguageCodeMatched ?? supportedSonaLocales.first;
}