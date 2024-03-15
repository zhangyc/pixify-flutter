import 'dart:io';

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
    super.initState();
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
                    ...recognizedTokens!.asMap().keys.map((index) => TextSpan(
                        text: '${recognizedTokens![index]}',
                        style: TextStyle(
                            color: Colors.transparent
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
                    ...translatedTokens!.asMap().keys.map((index) => TextSpan(
                        text: '${translatedTokens![index]}',
                        style: TextStyle(
                            color: Colors.transparent
                        )
                    ))
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (recognizedTokens != null && recognizedGap != null) Text.rich(TextSpan(
              children: [
                ...recognizedTokens!.asMap().keys.map((index) => TextSpan(
                  text: '${recognizedTokens![index]}',
                  style: TextStyle(
                    color: snapshot.data!.inMilliseconds > (200 + (index * recognizedGap!)) ? Theme.of(context).primaryColor : Colors.transparent
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
                ...translatedTokens!.asMap().keys.map((index) => TextSpan(
                    text: '${translatedTokens![index]}',
                    style: TextStyle(
                        color: snapshot.data!.inMilliseconds > (200 + (index * translatedGap!)) ? Theme.of(context).primaryColor : Colors.transparent
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