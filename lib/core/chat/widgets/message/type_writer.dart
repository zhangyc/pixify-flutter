import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/audio_message.dart';

import '../../providers/audio.dart';

class TypeWriter extends ConsumerStatefulWidget {
  const TypeWriter({
    super.key,
    required this.message,
  });
  final AudioMessage message;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TypeWriterState();
}

class _TypeWriterState extends ConsumerState<TypeWriter> {

  List<String>? recognizedTokens;
  List<String>? translatedTokens;
  int? recognizedGap;
  int? translatedGap;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TypeWriter oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    if (widget.message.duration != null) {
      if (widget.message.recognizedText != null && widget.message.recognizedText!.isNotEmpty) {
        recognizedTokens = widget.message.recognizedText!.split('');
        if (recognizedTokens!.length < 2) {
          recognizedGap = 200;
        } else {
          recognizedGap = (((widget.message.duration! * 1000) - 200 - 200) / (recognizedTokens!.length - 2 + 1)).floor();
        }
      }
      if (widget.message.translatedText != null && widget.message.translatedText!.isNotEmpty) {
        translatedTokens = widget.message.translatedText!.split('');
        if (translatedTokens!.length < 2) {
          translatedGap = 200;
        } else {
          translatedGap = (((widget.message.duration! * 1000) - 200 - 200) / (translatedTokens!.length - 2 + 1)).floor();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: ref.read(audioPlayerProvider(widget.message.chatId)).onPositionChanged,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (recognizedTokens != null && recognizedGap != null) Text.rich(TextSpan(
                  children: [
                    TextSpan(text: '')
                  ]
              ), style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).primaryColor,
                height: 1.5,
                fontFamilyFallback: [
                  if (Platform.isAndroid) 'Source Han Sans',
                  // if (Platform.isIOS && text?.languageCode.startsWith('zh') == true) 'PingFang SC',
                  // if (Platform.isIOS && text?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                ],
              )),
              if (translatedTokens != null && translatedGap != null) Text.rich(TextSpan(
                  children: [
                    TextSpan(text: '')
                  ]
              ), style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.transparent,
                height: 1.5,
                fontFamilyFallback: [
                  if (Platform.isAndroid) 'Source Han Sans',
                  // if (Platform.isIOS && text?.languageCode.startsWith('zh') == true) 'PingFang SC',
                  // if (Platform.isIOS && text?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                ],
              ))
            ],
          );
        }
        final seed = snapshot.data!.inMilliseconds;
        final recognizedIndex = seed < 200 ? 0 : ((seed - 200) / (recognizedGap ?? 10)).floor() + 1;
        final translatedIndex = seed < 200 ? 0 : ((seed - 200) / (translatedGap ?? 10)).floor() + 1;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (recognizedTokens != null && recognizedGap != null) Text.rich(TextSpan(
              children: [
                ...recognizedTokens!.sublist(0, min(recognizedTokens!.length, recognizedIndex)).map((t) => TextSpan(
                  text: t,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor
                  )
                ))
              ]
            ), style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).primaryColor,
                height: 1.5,
                fontFamilyFallback: [
                  if (Platform.isAndroid) 'Source Han Sans',
                  // if (Platform.isIOS && text?.languageCode.startsWith('zh') == true) 'PingFang SC',
                  // if (Platform.isIOS && text?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                ],
            )),
            if (translatedTokens != null && translatedGap != null) Text.rich(TextSpan(
              children: [
                ...translatedTokens!.sublist(0, min(translatedTokens!.length, translatedIndex)).map((t) => TextSpan(
                    text: t,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    )
                ))
              ]
            ), style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).primaryColor,
              height: 1.5,
              fontFamilyFallback: [
                if (Platform.isAndroid) 'Source Han Sans',
                // if (Platform.isIOS && text?.languageCode.startsWith('zh') == true) 'PingFang SC',
                // if (Platform.isIOS && text?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
              ],
            ))
          ],
        );
      }
    );
  }
}