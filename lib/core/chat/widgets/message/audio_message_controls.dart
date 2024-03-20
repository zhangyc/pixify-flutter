import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/audio_message.dart';
import 'package:sona/core/chat/providers/audio.dart';

class AudioMessageControls extends ConsumerStatefulWidget {
  const AudioMessageControls({
    super.key,
    required this.chatId,
    required this.message,
    required this.fromMe,
    required this.filePath,
    required this.duration,
  });
  final int chatId;
  final AudioMessage message;
  final bool fromMe;
  final String? filePath;
  final Duration duration;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioMessageControlsState();
}

class _AudioMessageControlsState extends ConsumerState<AudioMessageControls> {
  late final _width = widget.duration.inSeconds / 2 + 165;
  late final _bgColor = widget.fromMe ? Theme.of(context).primaryColor : const Color(0xFFF6F3F3);
  late final _playProgressColor = widget.fromMe ? const Color(0xFF454545) : const Color(0xFFE8E6E6);
  late final _contentColor = widget.fromMe ? Colors.white : Theme.of(context).primaryColor;
  late final player = ref.read(audioPlayerProvider(widget.chatId));

  @override
  Widget build(BuildContext context) {
    final isCurrent = ref.watch(currentPlayingAudioMessageIdProvider) == widget.message.uuid;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (widget.filePath == null) return;
        if (isCurrent) {
          if (player.state == PlayerState.paused) {
            player.resume();
          } else {
            player.pause();
          }
        } else {
          _play();
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.fromMe && isCurrent) _speedButton(),
          SizedBox(
            width: _width,
            child: StreamBuilder<Duration>(
              stream: player.onPositionChanged,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      border: Border.all(color: Color(0xFF2C2C2C), width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                        children: !widget.fromMe ? _controlsWidgets() : _controlsWidgets().reversed.toList()
                    ),
                  );
                }
                return Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: _bgColor,
                    border: Border.all(color: Color(0xFF2C2C2C), width: 1),
                    borderRadius: BorderRadius.circular(20),
                    gradient: isCurrent ? LinearGradient(
                      stops: [
                        snapshot.data!.inMilliseconds / widget.duration.inMilliseconds,
                        snapshot.data!.inMilliseconds / widget.duration.inMilliseconds,
                      ],
                      colors: [
                        _playProgressColor,
                        _bgColor
                      ]
                    ) : null
                  ),
                  child: Row(
                    children: !widget.fromMe ? _controlsWidgets() : _controlsWidgets().reversed.toList()
                  ),
                );
              }
            ),
          ),
          if (!widget.message.read && !isCurrent && !widget.fromMe) Container(
            margin: EdgeInsets.symmetric(horizontal: 6),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: Color(0xFFBEFF06),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
            ),
          ),
          if (!widget.fromMe && isCurrent) _speedButton()
        ],
      ),
    );
  }

  List<Widget> _controlsWidgets() {
    return [
      Icon(CupertinoIcons.waveform, size: 24, color: _contentColor),
      SizedBox(width: 12),
      Text('${(widget.duration.inMilliseconds / 1000).ceil().toString()}s',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _contentColor)
      ),
      Expanded(child: Container()),
      if (ref.watch(currentPlayingAudioMessageIdProvider) == widget.message.uuid) StreamBuilder<PlayerState>(
          stream: player.onPlayerStateChanged,
          builder: (_, snapshot) {
            if (snapshot.data == PlayerState.paused) {
              return Icon(CupertinoIcons.play, color: _contentColor,);
            }
            return Icon(CupertinoIcons.pause, color: _contentColor,);
          }
      ),
    ];
  }

  Widget _speedButton() {
    return GestureDetector(
      onTap: () {
        ref.read(audioMessagePlaySpeedProvider(widget.chatId).notifier).update((state) {
          return switch(state) {
            1.0 => 0.5,
            0.5 => 1.5,
            _ => 1.0
          };
        });
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
            color: Color(0xFFF6F3F3),
            borderRadius: BorderRadius.circular(12)
        ),
        alignment: Alignment.center,
        child: Text('${switch(ref.watch(audioMessagePlaySpeedProvider(widget.chatId))) {
          0.5 => 'x0.5',
          1.5 => 'x1.5',
          _ => 'x1'
        }}',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Future _play() async {
    await player.play(DeviceFileSource(widget.filePath!), position: const Duration(milliseconds: 0));
    ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => widget.message.uuid);
    if (!widget.message.read) widget.message.markAsRead();

    bool shutdown = false;
    ref.read(subProvider.notifier).update((state) => ref.listenManual(earpieceModeProvider, (prev, next) async {
      if (player.state == PlayerState.playing) {
        shutdown = true;
        await player.pause();
      }
      if (player.state == PlayerState.playing && next) {
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
    }));
  }
}

/// 参数: uuid
/// 不能用id，本地正在发送中的消息没有
final currentPlayingAudioMessageIdProvider = StateProvider<String?>((ref) => null);
