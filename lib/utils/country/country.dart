import 'dart:io';

import 'package:intl/locale.dart';

late final List<Map<String, dynamic>> countryMapList;

class SonaCountry {
  SonaCountry({
    required this.code,
    required this.displayName
  });
  final String code;
  final String displayName;

  factory SonaCountry.fromCode(String code) {
    final countryMap = countryMapList.firstWhere((cm) => cm['code'] == code);
    final nameTranslations = countryMap['nameTranslations'] as Map<String, String>;
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
      displayName: nameTranslations[lang]!
    );
  }
}

final supportedSonaCountries = countryMapList.map<SonaCountry>((cm) => SonaCountry.fromCode(cm['code']));
