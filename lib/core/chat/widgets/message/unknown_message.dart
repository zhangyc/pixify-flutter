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
import 'package:sona/core/chat/providers/message.dart';
import 'package:sona/core/chat/widgets/message/time.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../../common/providers/entitlements.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/toast/cooldown.dart';

class UnknownMessageWidget extends ConsumerStatefulWidget {
  const UnknownMessageWidget({
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
  ConsumerState<ConsumerStatefulWidget> createState() => _UnknownMessageWidgetState();
}

class _UnknownMessageWidgetState extends ConsumerState<UnknownMessageWidget> {

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
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onLongPress: () async {
                        final action = await showActionButtons(
                            context: context,
                            options: {
                              if (widget.fromMe) S.of(context).buttonDelete: 'delete'
                            }
                        );
                        if (action == 'delete') {
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
                              'Unknown message, please update the App',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: widget.fromMe ? Colors.white : Theme.of(context).primaryColor,
                                  height: 1.5,
                                  fontFamilyFallback: [
                                    if (Platform.isAndroid) 'Source Han Sans',
                                  ],
                                  locale: widget.myLocale
                              )
                          )
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.fromMe) Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: UserAvatar(url: widget.mySide.avatar!, size: Size.square(40)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
