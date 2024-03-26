import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sona/core/chat/widgets/message/audio_message_controls.dart';

final audioPlayerProvider = StateProvider.family<AudioPlayer, int>((ref, arg) {
  final player = AudioPlayer();
  player.onPlayerStateChanged.listen((playStateEvent) async {
    if (playStateEvent == PlayerState.playing) {
      ref.read(proximitySubscriptionProvider.notifier).update((state) => ProximitySensor.events.throttleTime(const Duration(milliseconds: 500)).listen((proximityEvent) async {
        if (player.state == PlayerState.playing) {
          await player.pause();
          if (proximityEvent == 1) {
            await player.setAudioContext(AudioContext(
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
            await player.setAudioContext(AudioContext(
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
          await player.resume();
        } else {
          ref.read(proximitySubscriptionProvider.notifier).update((state) => null);
        }
      },onError: (_) {}, cancelOnError: true));
    } else if (playStateEvent == PlayerState.completed) {
      final messageId = ref.read(currentPlayingAudioMessageIdProvider);
      if (messageId != null) {
        ref.read(playedAudioMessageUuidsProvider(arg).notifier).update((state) => {
          ...state,
          messageId // 当前播放的，播完后记下uuid
        });
      }
      ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => null);
      ref.read(proximitySubscriptionProvider.notifier).update((state) => null);
    } else if (playStateEvent == PlayerState.stopped) {
      ref.read(proximitySubscriptionProvider.notifier).update((state) => null);
    }
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

final proximitySubscriptionProvider = StateProvider<StreamSubscription?>((ref) {
  ref.listenSelf((previous, next) async {
    try {
      await previous?.cancel();
    } catch(e) {
      if (kDebugMode) print('Error on cancel listening Proximity Sensor stream: $e');
    }
  });
  return null;
});

