const _env = String.fromEnvironment('env', defaultValue: 'test');
const _apiServer = _env == 'prod'
  ? 'https://manager.sona.pinpon.fun/api'
  : 'https://admin-test.sona.pinpon.fun/api';
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
}

const env = _Env(env: _env, apiServer: _apiServer, firestorePrefix: _firestorePrefix);
