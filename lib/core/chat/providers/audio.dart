import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/widgets/message/audio_message_controls.dart';

final audioPlayerProvider = StateProvider.autoDispose.family<AudioPlayer, int>((ref, arg) {
  final player = AudioPlayer();
  player.onPlayerComplete.listen((event) {
    ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => null);
  });
  // ref.onDispose(() {
  //   if (player.playing) player.stop();
  //   player.dispose();
  // });
  return player;
});