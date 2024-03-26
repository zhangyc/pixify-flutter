
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/audio_message.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/widgets/message/audio_message_controls.dart';
import 'package:sona/core/chat/widgets/message/time.dart';
import 'package:sona/core/chat/widgets/message/type_writer.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../../generated/l10n.dart';
import '../../providers/audio.dart';

class AudioMessageWidget extends ConsumerStatefulWidget {
  const AudioMessageWidget({
    super.key,
    required this.prevMessage,
    required this.message,
    required this.mySide,
    required this.otherSide,
    required this.myLocale,
    required this.otherLocale,
  });

  final ImMessage? prevMessage;
  final AudioMessage message;
  final UserInfo mySide;
  final UserInfo otherSide;
  final Locale? myLocale;
  final Locale? otherLocale;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends ConsumerState<AudioMessageWidget> {

  bool get _fromMe => widget.message.sender.id == widget.mySide.id;
  var _loading = true;
  var _hasError = false;

  Duration? duration;
  String? url;
  String? localPath;
  String? text;
  String? translatedText;
  List<Map<String, dynamic>>? words;

  static final messageAudioCacheManager = CacheManager(
      Config('audio_message',
        maxNrOfCacheObjects: 2000,
        stalePeriod: Duration(days: 30)
      )
  );

  @override
  void initState() {
    try {
      Map map =  widget.message.content;
      url = map['url'];
      localPath = map['localExtension']?['path'];
      duration = Duration(milliseconds: (widget.message.duration! * 1000.0).toInt());
      text = map['recognizedText'];
      translatedText = map['translatedText'];
      words = map['words'];
    } catch(e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _hasError = true;
        });
      }
    }

    super.initState();
  }

  Future<File> _downloadAudioFile(String url) {
    // return messageAudioCacheManager.getSingleFile(url);
    if (Platform.isIOS) {
      return messageAudioCacheManager.getSingleFile(url).then((file) => file.rename(file.path.replaceAll('.bin', '.m4a')));
    } else {
      return messageAudioCacheManager.getSingleFile(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: _fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (localPath != null) AudioMessageControls(
            chatId: widget.otherSide.id ,
            message: widget.message,
            fromMe: _fromMe,
            filePath: localPath,
            duration: duration!,
          )
          else FutureBuilder(
            future: _downloadAudioFile(url!),
            builder: (_, c) {
              if (c.hasData) {
                localPath = c.data!.path;
                if (widget.message.content['localExtension'] == null) {
                  widget.message.content['localExtension'] = {'path': localPath};
                } else {
                  widget.message.content['localExtension']['path'] = localPath;
                }
              }
              return AudioMessageControls(
                key: ValueKey(widget.message.content['localExtension']?['path']),
                chatId: widget.otherSide.id,
                message: widget.message,
                fromMe: _fromMe,
                filePath: localPath,
                duration: duration!,
              );
            }
          ),
          SizedBox(height: 6),
          if (ref.watch(playedAudioMessageUuidsProvider(widget.message.chatId)).contains(widget.message.uuid) && ref.watch(currentPlayingAudioMessageIdProvider) != widget.message.uuid) Container(
            width: duration!.inSeconds / 2 + 144,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.message.recognizedText != null) Text(widget.message.recognizedText!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      height: 1.5,
                      fontFamilyFallback: [
                        if (Platform.isAndroid) 'Source Han Sans',
                        // if (Platform.isIOS && text?.languageCode.startsWith('zh') == true) 'PingFang SC',
                        // if (Platform.isIOS && text?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                      ],
                    )),
                if (widget.message.translatedText != null && widget.message.translatedText!.isNotEmpty) Text(widget.message.translatedText!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      height: 1.5,
                      fontFamilyFallback: [
                        if (Platform.isAndroid) 'Source Han Sans',
                        // if (Platform.isIOS && text?.languageCode.startsWith('zh') == true) 'PingFang SC',
                        // if (Platform.isIOS && text?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                      ],
                    )),
              ],
            ),
          )
          else if (ref.watch(currentPlayingAudioMessageIdProvider) == widget.message.uuid) Container(
              width: duration!.inSeconds / 2 + 144,
              child: TypeWriter(
                  key: ValueKey('${widget.message.recognizedText}-${widget.message.translatedText}'),
                  message: widget.message
              )
          )
        ],
      ),
    );
  }
}