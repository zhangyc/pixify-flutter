import 'dart:io';

import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';

const _env = String.fromEnvironment('ENV', defaultValue: 'prod');
const _apiServer = _env == 'prod'
  ? 'https://manager.sona.pinpon.fun/api'
  : 'http://test.sona.ninja/api';
const _firestorePrefix = _env == 'prod'
  ? 'prod'
  : 'test';

class _Env {
  const _Env({
    required this.env,
    required this.apiServer,
    required this.firestorePrefix
  });
  final String env;
  final String apiServer;
  final String firestorePrefix;
  final String staticDomain = 'https://h5.sona.ninja';

  String get privacyPolicy => '$staticDomain/privacy-policy-${findMatchedSonaLocale(profile?.locale ?? Platform.localeName).locale.toLanguageTag()}.html';
  String get termsOfService => '$staticDomain/terms-${findMatchedSonaLocale(profile?.locale ?? Platform.localeName).locale.toLanguageTag()}.html';
  String get disclaimer => '$staticDomain/disclaimer-${findMatchedSonaLocale(profile?.locale ?? Platform.localeName).locale.toLanguageTag()}.html';
}

const env = _Env(env: _env, apiServer: _apiServer, firestorePrefix: _firestorePrefix);
