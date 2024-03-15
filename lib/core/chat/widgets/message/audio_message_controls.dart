import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/audio_message.dart';
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
  final AudioMessage message;
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (isCurrent) {
          if (player.state == PlayerState.paused) {
            player.resume();
          } else {
            player.pause();
          }
        } else {
          ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => widget.message.uuid);
          player.play(DeviceFileSource(widget.file.path), position: Duration(milliseconds: 0));
        }
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 128,
          maxWidth: MediaQuery.of(context).size.width * 0.6
        ),
        child: Row(
          children: [
            if (widget.fromMe) GestureDetector(
              onTap: () {
                ref.read(audioMessagePlaySpeedProvider(widget.chatId).notifier).update((state) => state == 1.0 ? 0.5 : 1.0);
              },
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                    color: Color(0xFFF6F3F3),
                    borderRadius: BorderRadius.circular(12)
                ),
                alignment: Alignment.center,
                child: Text('x${ref.watch(audioMessagePlaySpeedProvider(widget.chatId)) == 1.0 ? '1' : '0.5'}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 48,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: _bgColor,
                  border: Border.all(color: Color(0xFF2C2C2C), width: 2),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Icon(Icons.multitrack_audio_outlined, size: 24),
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
                  ],
                ),
              ),
            ),
            if (!widget.fromMe) GestureDetector(
              onTap: () {
                ref.read(audioMessagePlaySpeedProvider(widget.chatId).notifier).update((state) => state == 1.0 ? 1.5 : 1.0);
              },
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(left: 6),
                decoration: BoxDecoration(
                    color: Color(0xFFF6F3F3),
                    borderRadius: BorderRadius.circular(12)
                ),
                alignment: Alignment.center,
                child: Text('x${ref.watch(audioMessagePlaySpeedProvider(widget.chatId)) == 1.0 ? '1' : '1.5'}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// 参数: uuid
/// 不能用id，本地正在发送中的消息没有
final currentPlayingAudioMessageIdProvider = StateProvider<String?>((ref) => null);
