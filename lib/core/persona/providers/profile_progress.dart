import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';

final profileProgressProvider = StateProvider<double>((ref) {
  int value = 0;
  final profile = ref.watch(myProfileProvider)!;
  value += switch(profile.photos.length) {
    0 => 0,
    1 => 30,
    2 => 45,
    _ => 60
  };
  if (profile.bio != null && profile.bio!.isNotEmpty) {
    value += 20;
  }
  if (profile.interests.isNotEmpty) {
    value += 20;
  }
  return value / 100;
}, dependencies: [myProfileProvider]);