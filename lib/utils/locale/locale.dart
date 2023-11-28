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
}

final supportedSonaLocales = [
  SonaLocale.fromLanguageTag('en-US', 'English (US)'),
  SonaLocale.fromLanguageTag('en-GB', 'English (UK)'),
  SonaLocale.fromLanguageTag('ja-JP', '日本語'),
  SonaLocale.fromLanguageTag('zh-CN', '简体中文'),
  SonaLocale.fromLanguageTag('zh-TW', '繁體中文'),
  SonaLocale.fromLanguageTag('ko-KR', '한국어'),
  SonaLocale.fromLanguageTag('th-TH', 'ภาษาไทย'),
  SonaLocale.fromLanguageTag('pt-PT', 'Português'),
  SonaLocale.fromLanguageTag('pt-BR', 'Português (Brasil)'),
  SonaLocale.fromLanguageTag('es-ES', 'Español'),
  SonaLocale.fromLanguageTag('fr-FR', 'Français'),
  SonaLocale.fromLanguageTag('de-DE', 'Deutsch'),
  SonaLocale.fromLanguageTag('it-IT', 'Italiano'),
  SonaLocale.fromLanguageTag('ru-RU', 'Русский'),
  SonaLocale.fromLanguageTag('yue', '粵語'),
];

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