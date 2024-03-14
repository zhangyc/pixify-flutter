
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
import 'package:sona/core/chat/widgets/message/typer.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../../generated/l10n.dart';
import '../../providers/audio.dart';

class AudioMessageWidget extends ConsumerStatefulWidget {
  const AudioMessageWidget({
    super.key,
    required this.prevMessage,
    required this.message,
    required this.fromMe,
    required this.mySide,
    required this.otherSide,
    required this.myLocale,
    required this.otherLocale,
    required this.onDelete,
    this.onResend,
    this.onAvatarTap
  });

  final ImMessage? prevMessage;
  final AudioMessage message;
  final bool fromMe;
  final UserInfo mySide;
  final UserInfo otherSide;
  final Locale? myLocale;
  final Locale? otherLocale;
  final Future Function(ImMessage) onDelete;
  final Future Function(ImMessage)? onResend;
  final Function()? onAvatarTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends ConsumerState<AudioMessageWidget> {

  var _clicked = true;

  var _loading = true;
  var _hasError = false;
  bool get _hasData => !_loading && !_hasError;

  Duration? duration;
  String? url;
  String? localPath;
  String? text;
  String? translatedText;
  List<Map<String, dynamic>>? words;

  static final messageAudioCacheManager = CacheManager(
      Config('audio_message')
  );

  @override
  void initState() {
    try {
      Map map =  widget.message.content;
      url = map['url'];
      localPath = map['localExtension']?['path'];
      duration = Duration(milliseconds: (map['duration'] * 1000.0).toInt());
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.prevMessage == null || widget.prevMessage!.time.add(const Duration(minutes: 5)).isBefore(widget.message.time))
            MessageTime(time: widget.message.time),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: widget.fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.fromMe) Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                    onTap: widget.onAvatarTap,
                    child: UserAvatar(url: widget.otherSide.avatar!, size: Size.square(40))
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: widget.fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (localPath != null) AudioMessageControls(
                      chatId: widget.otherSide.id ,
                      message: widget.message,
                      fromMe: widget.fromMe,
                      file: File(localPath!),
                      duration: duration!,
                    )
                    else FutureBuilder(
                      future: messageAudioCacheManager.getSingleFile(url!),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: SizedBox(width: 32, height: 32, child: CircularProgressIndicator()));
                        }
                        if (snapshot.hasError) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: const Text('some error happens'),
                          );
                        }
                        if (snapshot.hasData) {
                          localPath = snapshot.data!.path;
                          if (widget.message.content['localExtension'] == null) {
                            widget.message.content['localExtension'] = {'path': localPath};
                          } else {
                            widget.message.content['localExtension']['path'] = localPath;
                          }
                          return AudioMessageControls(
                            chatId: widget.otherSide.id,
                            message: widget.message,
                            fromMe: widget.fromMe,
                            file: snapshot.data!,
                            duration: duration!,
                          );
                        }
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: const Text('some error happens'),
                        );
                      }
                    ),
                    if (text != null && text!.length > 1 && ref.watch(currentPlayingAudioMessageIdProvider) == widget.message.uuid) GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onLongPress: () async {
                        final action = await showActionButtons(
                            context: context,
                            options: {
                              S.of(context).buttonCopy: 'copy',
                              if (widget.fromMe) S.of(context).buttonDelete: 'delete'
                            }
                        );
                        if (action == 'copy') {
                          Clipboard.setData(ClipboardData(text: text!));
                          Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
                        } else if (action == 'delete') {
                          widget.onDelete(widget.message);
                        }
                      },
                      child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.64,
                          ),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     color: widget.fromMe ? Theme.of(context).primaryColor : Colors.transparent
                          // ),
                          // foregroundDecoration: widget.fromMe ? null : BoxDecoration(
                          //     border: Border.all(width: 2),
                          //     borderRadius: BorderRadius.circular(20)
                          // ),
                          padding: EdgeInsets.all(12),
                          // clipBehavior: Clip.antiAlias,
                          child: StreamBuilder<Duration>(
                            stream: ref.read(audioPlayerProvider(widget.otherSide.id)).onPositionChanged,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return Container();
                              return TypeWriter(
                                message: widget.message,
                                duration: snapshot.data!,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    height: 1.5,
                                    fontFamilyFallback: [
                                      if (Platform.isAndroid) 'Source Han Sans',
                                      // if (Platform.isIOS && text?.languageCode.startsWith('zh') == true) 'PingFang SC',
                                      // if (Platform.isIOS && text?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                                    ],
                                    locale: widget.myLocale
                                )
                              );
                            }
                          )
                      ),
                    ),
                    // SizedBox(height: 12),
                    if (translatedText != null && translatedText!.isNotEmpty) GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          _clicked = !_clicked;
                        });
                      },
                      onLongPress: () async {
                        final action = await showActionButtons(
                            context: context,
                            options: {
                              S.of(context).buttonCopy: 'copy',
                            }
                        );
                        if (action == 'copy') {
                          Clipboard.setData(ClipboardData(text: translatedText!));
                          Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
                        }
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.64,
                        ),
                        padding: EdgeInsets.all(12),
                        alignment: widget.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Text(
                          translatedText!,
                          maxLines: _clicked ? null : 1,
                          overflow: _clicked ? TextOverflow.clip : TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Color(0xFFB7B7B7),
                              height: 1.5,
                              fontFamilyFallback: [
                                if (Platform.isAndroid) 'Source Han Sans',
                                // if (Platform.isIOS && translatedText?.languageCode.startsWith('zh') == true) 'PingFang SC',
                                // if (Platform.isIOS && translatedText?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                              ],
                              locale: widget.otherLocale
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (widget.fromMe) Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: UserAvatar(url: widget.mySide.avatar!, size: Size.square(40)),
              ),
            ],
          ),
          // if (widget.message.sendingParams != null) ref.watch(asyncMessageSendingProvider(widget.message.sendingParams!)).when(
          //     data: (data) {
          //       if (data.success) {
          //         return Container();
          //       } else {
          //         return switch (data.error) {
          //           MessageSendingError.maximumLimit => Container(),
          //           MessageSendingError.contentFilter => Container(),
          //           _ => Row(
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               ColoredButton(
          //                   onTap: () {
          //                     widget.onResend!(widget.message);
          //                   },
          //                   color: Color(0xFFF6F3F3),
          //                   fontColor: Theme.of(context).primaryColor,
          //                   borderColor: Colors.transparent,
          //                   text: S.current.buttonResend
          //               ),
          //             ],
          //           )
          //         };
          //       }
          //     },
          //     error: (_, __) => Container(),
          //     loading: () => Container()
          // )
        ],
      ),
    );
  }
}