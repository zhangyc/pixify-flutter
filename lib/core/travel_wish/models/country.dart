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

String findFlagByCountryCode(String? code) {
  final country = supportedSonaCountries.firstWhere((c) => c.code == code, orElse: () => SonaCountry(code: '', displayName: 'Unknown', flag: '🌍'));
  return country.flag;
}

SonaCountry findCountryByCode(String? code) {
  return supportedSonaCountries.firstWhere((c) => c.code == code, orElse: () => SonaCountry(code: '', displayName: 'Unknown', flag: '🌍'));
}

class PopularTravelCountry {
  PopularTravelCountry({
    required this.id,
    required this.code,
    required this.displayName,
    required this.cities
  });
  final int id;
  final String? code;
  final String displayName;
  final List<PopularTravelCity> cities;

  factory PopularTravelCountry.fromJson(Map<String, dynamic> json) {
    return PopularTravelCountry(
        id: json['id'],
        code: json['countryCode'],
        displayName: json['title'],
        cities: (json['children'] as List? ?? []).map<PopularTravelCity>((cityMap) => PopularTravelCity.fromJson(cityMap)).toList(growable: false)
    );
  }
}

class PopularTravelCity {
  PopularTravelCity({
    required this.id,
    required this.displayName,
    required this.popular
  });
  final int id;
  final String displayName;
  final bool popular;

  factory PopularTravelCity.fromJson(Map<String, dynamic> json) {
    return PopularTravelCity(
      id: json['id'],
      displayName: json['title'],
      popular: json['hot'] ?? false
    );
  }
}