import 'dart:io';

import 'package:intl/locale.dart';

late final List<Map<String, dynamic>> countryMapList;

class SonaCountry {
  SonaCountry({
    required this.code,
    required this.displayName,
    required this.flag
  });
  final String code;
  final String displayName;
  final String flag;

  factory SonaCountry.fromCode(String code) {
    final countryMap = countryMapList.firstWhere((cm) => cm['code'] == code);
    final nameTranslations = countryMap['nameTranslations'] as Map<String, dynamic>;
    final locale = Locale.tryParse(Platform.localeName);
    String lang;
    if (locale == null) {
      lang = 'en';
    } else if (nameTranslations.keys.contains(locale.toLanguageTag())) {
      lang = locale.toLanguageTag();
    } else if (nameTranslations.keys.contains(locale.languageCode)) {
      lang = locale.languageCode;
    } else {
      lang = 'en';
    }
    return SonaCountry(
      code: countryMap['code'],
      displayName: nameTranslations[lang]!,
      flag: countryMap['flag']
    );
  }
}

final supportedSonaCountries = countryMapList.map<SonaCountry>((cm) => SonaCountry.fromCode(cm['code']));
final hotTravelCountries = List<SonaCountry>.from(supportedSonaCountries)..retainWhere((country) => ['US', 'JP', 'CN', 'KR', 'TH', 'IT', 'FR'].contains(country.code));

String findFlagByCountryCode(String code) {
  final country = supportedSonaCountries.firstWhere((c) => c.code == code, orElse: () => SonaCountry(code: code, displayName: 'Unknown', flag: '🌍'));
  return country.flag;
}