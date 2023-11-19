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
  SonaLocale.fromLanguageTag('en-US', 'English (United States)'),
  SonaLocale.fromLanguageTag('en-GB', 'English (United Kingdom)'),
  SonaLocale.fromLanguageTag('zh-CN', '简体中文'),
  SonaLocale.fromLanguageTag('zh-TW', '繁體中文'),
  SonaLocale.fromLanguageTag('ja-JP', '日本語'),
  SonaLocale.fromLanguageTag('ko-KR', '한국어(대한민국)'),
  SonaLocale.fromLanguageTag('ar-ME', 'العربية (الشرق الأوسط)'),
  SonaLocale.fromLanguageTag('pt-BR', 'Português (Brasil)'),
  SonaLocale.fromLanguageTag('es-LA', 'Español (Latinoamérica)'),
  SonaLocale.fromLanguageTag('ru-RU', 'Русский (Россия)'),
  SonaLocale.fromLanguageTag('fr-FR', 'Français (France)'),
  SonaLocale.fromLanguageTag('th-TH', 'ภาษาไทย (ประเทศไทย)'),
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