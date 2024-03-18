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
  });

  bool shutdown = false;
  ref.listen(earpieceModeProvider, (prev, next) async {
    if (player.state == PlayerState.playing) {
      shutdown = true;
      await player.pause();
    }
    if (next) {
      player.setAudioContext(AudioContext(
        android: AudioContextAndroid(
          isSpeakerphoneOn: false, // 关闭扬声器
          audioMode: AndroidAudioMode.inCommunication, // 通话模式
          contentType: AndroidContentType.speech, // 语音内容类型
          usageType: AndroidUsageType.voiceCommunication, // 语音通信用途
          audioFocus: AndroidAudioFocus.gainTransient, // 获取临时音频焦点
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playAndRecord, // 播放和录音类别
          options: [
            AVAudioSessionOptions.allowBluetooth, // 允许蓝牙设备
          ],
        )
      ));
    } else {
      player.setAudioContext(AudioContext(
        android: AudioContextAndroid(
          isSpeakerphoneOn: true, // 打开扬声器
          audioMode: AndroidAudioMode.normal, // 普通模式
          contentType: AndroidContentType.music, // 音乐内容类型
          usageType: AndroidUsageType.media, // 媒体用途
          audioFocus: AndroidAudioFocus.gainTransient, // 获取临时音频焦点
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback, // 播放类别
          options: [
            // AVAudioSessionOptions.defaultToSpeaker, // 默认使用扬声器
          ],
        )
      ));
    }
    if (player.state == PlayerState.paused && shutdown) {
      await player.resume();
    }
  });
  return player;
}, dependencies: [earpieceModeProvider]);

final playedAudioMessageUuidsProvider = StateProvider.family<Set<String>, int>((ref, arg) => {});

final audioMessagePlaySpeedProvider = StateProvider.family<double, int>((ref, arg) {
  var speed = 1.0;
  ref.listenSelf((previous, next) {
    ref.read(audioPlayerProvider(arg)).setPlaybackRate(next);
  });
  return speed;
});

/// 是否听筒模式
final proximityStreamProvider = StreamProvider<bool>((ref) {
  return ProximitySensor.events.map<bool>((event) {
    return event > 0;
  });
});

/// 是否听筒模式
final earpieceModeProvider = StateProvider<bool>((ref) {
  return ref.watch(proximityStreamProvider).when(data: (d) => d, error: (_, __) => false, loading: () => false);
}, dependencies: [proximityStreamProvider]);
