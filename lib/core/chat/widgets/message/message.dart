
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
import 'package:sona/core/chat/widgets/message/text_message.dart';
import 'package:sona/core/chat/widgets/message/time.dart';
import 'package:sona/core/chat/widgets/message/type_writer.dart';
import 'package:sona/core/chat/widgets/message/unknown_message.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../../generated/l10n.dart';
import '../../models/image_message.dart';
import '../../models/text_message.dart';
import '../../providers/audio.dart';
import 'audio_message.dart';
import 'image_message.dart';

class ImMessageWidget extends ConsumerStatefulWidget {
  const ImMessageWidget({
    super.key,
    required this.prevMessage,
    required this.message,
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
  final UserInfo mySide;
  final UserInfo otherSide;
  final Locale? myLocale;
  final Locale? otherLocale;
  final Future Function(ImMessage) onDelete;
  final Future Function(ImMessage)? onResend;
  final Function()? onAvatarTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImMessageWidgetState();
}

class _ImMessageWidgetState extends ConsumerState<ImMessageWidget> {
  bool get _fromMe => widget.message.sender.id == widget.mySide.id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(
        left: _fromMe ? 80 : 0,
        right: !_fromMe ? 80 : 0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.prevMessage == null || widget.prevMessage!.time.add(const Duration(minutes: 5)).isBefore(widget.message.time))
            MessageTime(time: widget.message.time),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: _fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_fromMe) Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                    onTap: widget.onAvatarTap,
                    child: UserAvatar(url: widget.otherSide.avatar!, size: Size.square(40))
                ),
              ),
              switch(widget.message.runtimeType) {
                TextMessage => TextMessageWidget(
                  prevMessage: widget.prevMessage,
                  message: widget.message,
                  mySide: widget.mySide,
                  otherSide: widget.otherSide,
                  myLocale: widget.myLocale,
                  otherLocale: widget.otherLocale
                ),
                ImageMessage => ImageMessageWidget(
                  prevMessage: widget.prevMessage,
                  message: widget.message,
                  mySide: widget.mySide,
                  otherSide: widget.otherSide,
                  myLocale: widget.myLocale,
                  otherLocale: widget.otherLocale
                ),
                AudioMessage => AudioMessageWidget(
                  prevMessage: widget.prevMessage,
                  message: widget.message as AudioMessage,
                  mySide: widget.mySide,
                  otherSide: widget.otherSide,
                  myLocale: widget.myLocale,
                  otherLocale: widget.otherLocale
                ),
                _ => UnknownMessageWidget(
                  prevMessage: widget.prevMessage,
                  message: widget.message,
                  mySide: widget.mySide,
                  otherSide: widget.otherSide,
                  myLocale: widget.myLocale,
                  otherLocale: widget.otherLocale
                )
              },
              if (_fromMe) Padding(
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