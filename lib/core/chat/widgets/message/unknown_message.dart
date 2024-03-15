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
    required this.mySide,
    required this.otherSide,
    required this.myLocale,
    required this.otherLocale,
  });

  final ImMessage? prevMessage;
  final ImMessage message;
  final UserInfo mySide;
  final UserInfo otherSide;
  final Locale? myLocale;
  final Locale? otherLocale;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UnknownMessageWidgetState();
}

class _UnknownMessageWidgetState extends ConsumerState<UnknownMessageWidget> {
  bool get _fromMe => widget.message.sender.id == widget.mySide.id;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: _fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.64,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _fromMe ? Theme.of(context).primaryColor : Colors.transparent
            ),
            foregroundDecoration: _fromMe ? null : BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(20)
            ),
            padding: EdgeInsets.all(12),
            clipBehavior: Clip.antiAlias,
            child: Text(
              'Unknown message, please update the App',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _fromMe ? Colors.white : Theme.of(context).primaryColor,
                height: 1.5,
                fontFamilyFallback: [
                  if (Platform.isAndroid) 'Source Han Sans',
                ],
                locale: widget.myLocale
              )
            )
          ),
        ],
      ),
    );
  }
}
