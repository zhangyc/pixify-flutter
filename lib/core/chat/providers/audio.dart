import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/widgets/message/audio_message_controls.dart';

final audioPlayerProvider = StateProvider.family<AudioPlayer, int>((ref, arg) {
  final player = AudioPlayer();
  player.onPlayerComplete.listen((event) {
    ref.read(playedAudioMessageUuidsProvider(arg).notifier).update((state) => {
      ...state,
      ref.read(currentPlayingAudioMessageIdProvider)! // 当前播放的，播完后记下uuid
    });
    ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => null);
  });
  return player;
});

final playedAudioMessageUuidsProvider = StateProvider.family<Set<String>, int>((ref, arg) => {});