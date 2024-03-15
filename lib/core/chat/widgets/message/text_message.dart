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

class TextMessageWidget extends ConsumerStatefulWidget {
  const TextMessageWidget({
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
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends ConsumerState<TextMessageWidget> {

  bool get _fromMe => widget.message.sender.id == widget.mySide.id;
  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    String? upperMessage;
    String? lowerMessage;
    Locale? upperLocale;
    Locale? lowerLocale;

    upperLocale = widget.myLocale;
    lowerLocale = widget.otherLocale;
    if (_fromMe) {
      upperMessage = widget.message.content['originalText'];
      lowerMessage = widget.message.content['translatedText'];
    } else {
      upperMessage = widget.message.content['translatedText'];
      lowerMessage = widget.message.content['originalText'];
    }
    if (upperMessage == null || upperMessage.isEmpty) {
      upperMessage = lowerMessage;
      lowerMessage = null;
    }

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
                upperMessage!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _fromMe ? Colors.white : Theme.of(context).primaryColor,
                    height: 1.5,
                    fontFamilyFallback: [
                      if (Platform.isAndroid) 'Source Han Sans',
                      if (Platform.isIOS && upperLocale?.languageCode.startsWith('zh') == true) 'PingFang SC',
                      if (Platform.isIOS && upperLocale?.languageCode.startsWith('ja') == true) 'Hiragino Sans',
                    ],
                    locale: widget.myLocale
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
              alignment: _fromMe ? Alignment.centerRight : Alignment.centerLeft,
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
    );
  }
}
