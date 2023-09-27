part of 'global.dart';

const tokenKey = 'token';

String? _token;

String? get token {
  _token ??= kvStore.getString(tokenKey);
  return _token;
}
set token(String? value) {
  _token = value;
  if (value == null) {
    kvStore.remove(tokenKey);
    kvStore.remove(profileKey);
  } else {
    kvStore.setString(tokenKey, value);
  }
}

int? get userId {
  if (token == null) return null;
  final jwt = JwtDecoder.tryDecode(token!);
  final tokenStr = jwt?['sub'];
  if (tokenStr != null) return int.tryParse(tokenStr);
  return null;
}