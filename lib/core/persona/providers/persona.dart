import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/utils/providers/dio.dart';

import '../models/persona.dart';

class PersonaNotifier extends AsyncNotifier<Persona?> {
  Future<Persona?> _fetchPersona() async {
     final dio = ref.watch(dioProvider);
     final persona = Persona.fromJson(((await dio.get('/persona/character')) as Map)['data']['data']);
     return persona;
  }

  @override
  Future<Persona?> build() {
    return _fetchPersona();
  }

  Future<void> setCharacter(String name) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final dio = ref.watch(dioProvider);
      await dio.post('/persona', data: {'character': name});
      return _fetchPersona();
    });
  }

  Future<void> setIntro(String content) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final dio = ref.watch(dioProvider);
      await dio.post('/persona', data: state.value);
      return _fetchPersona();
    });
  }
}

final personaProvider = FutureProvider<PersonaNotifier>((ref) {
  return PersonaNotifier();
});