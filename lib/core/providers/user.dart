import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/persona/models/user.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/security/jwt_decoder.dart';

final userProvider = StateProvider<User>(
  (ref) {
    final token = ref.watch(tokenProvider);
    if (token == null) {
      return User(phone: '', name: '');
    }
    final user = JwtDecoder.tryDecode(token);
    return User.fromJson(user!);
  }
);