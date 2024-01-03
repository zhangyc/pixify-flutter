import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/models/message_type.dart';
import 'package:sona/core/chat/providers/message.dart';
import 'package:sona/core/chat/widgets/inputbar/mode_provider.dart';
import 'package:sona/core/chat/widgets/message/time.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../../common/providers/entitlements.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/global/global.dart';
import '../../../../utils/toast/cooldown.dart';
import '../../providers/chat.dart';

class MessageWidget extends ConsumerStatefulWidget {
  const MessageWidget({
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
  final ImMessage message;
  final bool fromMe;
  final UserInfo mySide;
  final UserInfo otherSide;
  final Locale? myLocale;
  final Locale? otherLocale;
  final Future Function(ImMessage) onDelete;
  final Future Function(ImMessage)? onResend;
  final Function()? onAvatarTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends ConsumerState<MessageWidget> {

  bool _clicked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? upperMessage;
    String? lowerMessage;
    Locale? upperLocale;
    Locale? lowerLocale;

    if (widget.fromMe) {
      upperLocale = widget.myLocale;
      if (widget.message.sendingParams != null) {
        upperMessage = widget.message.originalContent;
        lowerMessage = ref.watch(asyncMessageSendingProvider(widget.message.sendingParams!)).when(
          data: (data) {
            if (data.success) {
              return data.data?['txt'] ?? '';
            } else {
              switch (data.error) {
                case MessageSendingError.maximumLimit:
                  if (ref.read(myProfileProvider)!.isMember) {
                    coolDownDaily();
                  } else {
                    ref.read(entitlementsProvider.notifier).limit(interpretation: 0);
                  }
                  return S.current.toastHitDailyMaximumLimit;
                case MessageSendingError.contentFilter:
                  return S.current.exceptionSonaContentFilterTips;
                default:
                  return S.current.exceptionFailedToSendTips;
              }
            }
          },
          error: (_, __) => S.current.exceptionFailedToSendTips,
          loading: () => '...'
        );
      } else {
        upperMessage = widget.message.originalContent;
        lowerMessage = widget.message.translatedContent;
      }
    } else {
      lowerLocale = widget.otherLocale;
      upperMessage = widget.message.translatedContent;
      lowerMessage = widget.message.originalContent;
    }
    if (upperMessage == null || upperMessage.isEmpty) {
      upperMessage = lowerMessage;
      lowerMessage = null;
    }

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
                    GestureDetector(
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
                          Clipboard.setData(ClipboardData(text: upperMessage!));
                          Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
                        } else if (action == 'delete') {
                          widget.onDelete(widget.message);
                        }
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.64,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widget.fromMe ? Theme.of(context).primaryColor : Colors.transparent
                        ),
                        foregroundDecoration: widget.fromMe ? null : BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.all(12),
                        clipBehavior: Clip.antiAlias,
                        child: Text(
                          upperMessage!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: widget.fromMe ? Colors.white : Theme.of(context).primaryColor,
                            height: 1.5,
                            fontFamilyFallback: [
                              if (Platform.isAndroid) 'Source Han Sans',
                              if (Platform.isIOS && upperLocale?.languageCode.startsWith('zh') == true) 'PingFang SC',
                              if (Platform.isIOS && upperLocale?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                            ],
                            locale: widget.myLocale
                          )
                        )
                      ),
                    ),
                    // SizedBox(height: 12),
                    if (lowerMessage != null && lowerMessage.isNotEmpty) GestureDetector(
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
                          Clipboard.setData(ClipboardData(text: lowerMessage!));
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
                          lowerMessage,
                          maxLines: _clicked ? null : 1,
                          overflow: _clicked ? TextOverflow.clip : TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Color(0xFFB7B7B7),
                            height: 1.5,
                            fontFamilyFallback: [
                              if (Platform.isAndroid) 'Source Han Sans',
                              if (Platform.isIOS && lowerLocale?.languageCode.startsWith('zh') == true) 'PingFang SC',
                              if (Platform.isIOS && lowerLocale?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
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
          if (widget.message.sendingParams != null) ref.watch(asyncMessageSendingProvider(widget.message.sendingParams!)).when(
            data: (data) {
              if (data.success) {
                return Container();
              } else {
                return switch (data.error) {
                  MessageSendingError.maximumLimit => Container(),
                  MessageSendingError.contentFilter => Container(),
                  _ => Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColoredButton(
                          onTap: () {
                            widget.onResend!(widget.message);
                          },
                          color: Color(0xFFF6F3F3),
                          fontColor: Theme.of(context).primaryColor,
                          borderColor: Colors.transparent,
                          text: S.current.buttonResend
                      ),
                    ],
                  )
                };
              }
            },
            error: (_, __) => Container(),
            loading: () => Container()
          )
        ],
      ),
    );
  }
}