import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sona/core/chat/widgets/message/audio_message_controls.dart';

final audioPlayerProvider = StateProvider.family<AudioPlayer, int>((ref, arg) {
  final player = AudioPlayer();
  player.onPlayerComplete.listen((event) {
    ref.read(playedAudioMessageUuidsProvider(arg).notifier).update((state) => {
      ...state,
      ref.read(currentPlayingAudioMessageIdProvider)! // 当前播放的，播完后记下uuid
    });
    ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => null);
    ref.read(subProvider.notifier).update((state) => null);
  });

  return player;
});

final playedAudioMessageUuidsProvider = StateProvider.autoDispose.family<Set<String>, int>((ref, arg) => {});

final audioMessagePlaySpeedProvider = StateProvider.family<double, int>((ref, arg) {
  var speed = 1.0;
  ref.listenSelf((previous, next) {
    ref.read(audioPlayerProvider(arg)).setPlaybackRate(next);
  });
  return speed;
});

/// 是否听筒模式
final proximityStreamProvider = StreamProvider.autoDispose<bool>((ref) {
  return ProximitySensor.events.map<bool>((event) {
    return event > 0;
  });
});

/// 是否听筒模式
final earpieceModeProvider = StateProvider.autoDispose<bool>((ref) {
  return ref.watch(proximityStreamProvider).when(data: (d) => d, error: (_, __) => false, loading: () => false);
}, dependencies: [proximityStreamProvider]);

final subProvider = StateProvider<ProviderSubscription?>((ref) {
  ref.listenSelf((previous, next) {
    previous?.close();
  });
  return null;
});

