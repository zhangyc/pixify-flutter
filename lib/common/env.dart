const _env = String.fromEnvironment('env', defaultValue: 'prod');
const _apiServer = _env == 'prod'
  ? 'https://manager.sona.pinpon.fun/api'
  : 'https://admin-test.sona.pinpon.fun/api';
const _firestorePrefix = _env == 'prod'
  ? 'prod'
  : 'test';
final env = _Env(env: _env, apiServer: _apiServer, firestorePrefix: _firestorePrefix);

class _Env {
  _Env({
    required this.env,
    required this.apiServer,
    required this.firestorePrefix
  });
  final String env;
  final String apiServer;
  final String firestorePrefix;
}