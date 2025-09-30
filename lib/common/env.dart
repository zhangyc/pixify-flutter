import 'dart:io';

import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';

const _env = String.fromEnvironment('ENV', defaultValue: 'prod');
const _apiServer = _env == 'prod'
    ? 'https://pixify-api.aegis-labs.com/api/'
    : 'https://a7ee4742cc6d.ngrok-free.app/api/';
const _firestorePrefix = _env == 'prod' ? 'prod' : 'test';

/// 新的aegis前缀

const _aegisPrefix = _env == 'prod' ? 'aegis_prod_' : 'aegis_local_';

class _Env {
  const _Env({
    required this.env,
    required this.apiServer,
    required this.firestorePrefix,
    required this.aegisPrefix,
  });
  final String env;
  final String apiServer;
  final String firestorePrefix;
  final String staticDomain = 'https://pixify.aegis-labs.com/';
  final String aegisPrefix;
  String get privacyPolicy =>
      'https://pixify-rp.web.app/privacy-policy-astro.html';
  String get termsOfService =>
      'https://pixify-rp.web.app/terms-and-conditions-astro.html';
  String get disclaimer => 'https://pixify-rp.web.app/disclaimer-astro.html';
}

const env = _Env(
  env: _env,
  apiServer: _apiServer,
  firestorePrefix: _firestorePrefix,
  aegisPrefix: _aegisPrefix,
);
