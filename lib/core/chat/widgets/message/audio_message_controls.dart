import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/audio.dart';

class AudioMessageControls extends ConsumerStatefulWidget {
  const AudioMessageControls({
    super.key,
    required this.chatId,
    required this.message,
    required this.fromMe,
    required this.file,
    required this.duration,
  });
  final int chatId;
  final ImMessage message;
  final bool fromMe;
  final File file;
  final Duration duration;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioMessageControlsState();
}

class _AudioMessageControlsState extends ConsumerState<AudioMessageControls> {
  late final _bgColor = widget.fromMe ? Color(0xFFF6F3F3) : Color(0xFF2C2C2C);

  late final player = ref.read(audioPlayerProvider(widget.chatId));

  @override
  Widget build(BuildContext context) {
    final isCurrent = ref.watch(currentPlayingAudioMessageIdProvider) == widget.message.uuid;
    return Container(
      constraints: BoxConstraints(
        minWidth: 128,
        maxWidth: MediaQuery.of(context).size.width * 0.6
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _bgColor,
        border: Border.all(color: Color(0xFF2C2C2C), width: 2),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          if (player.state == PlayerState.playing) Icon(Icons.multitrack_audio_outlined, size: 24),
          SizedBox(width: 12),
          Text('${widget.duration.inSeconds.toString()}s'),
          Expanded(child: Container()),
          if (isCurrent) StreamBuilder<PlayerState>(
              stream: player.onPlayerStateChanged,
              builder: (_, snapshot) {
                if (snapshot.data == PlayerState.paused) {
                  return IconButton(
                      iconSize: 24,
                      onPressed: () async {
                        await player.resume();
                      },
                      icon: Icon(Icons.play_arrow)
                  );
                }
                return IconButton(
                    iconSize: 24,
                    onPressed: () async {
                      await player.pause();
                    },
                    icon: Icon(Icons.pause_circle_outline)
                );
              }
          ),
          if (!isCurrent) IconButton(
              iconSize: 24,
              onPressed: () async {
                ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => widget.message.uuid);
                player.play(DeviceFileSource(widget.file.path));
              },
              icon: Icon(Icons.play_arrow)
          )
        ],
      ),
    );
  }
}

/// 参数: uuid
/// 不能用id，本地正在发送中的消息没有
final currentPlayingAudioMessageIdProvider = StateProvider<String?>((ref) => null);
