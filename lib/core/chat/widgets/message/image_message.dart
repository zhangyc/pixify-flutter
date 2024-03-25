
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/widgets/message/time.dart';
import 'package:sona/core/match/widgets/image_preview.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/global/global.dart';
import '../../../match/util/event.dart';

class ImageMessageWidget extends ConsumerStatefulWidget {
  const ImageMessageWidget({
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

class _MessageWidgetState extends ConsumerState<ImageMessageWidget> {

  bool get _fromMe => widget.message.sender.id == widget.mySide.id;
  late String url='';

  @override
  void initState() {
    try {
      if (widget.message.content.isNotEmpty){
        Map map = widget.message.content;
        url=map['image'];
      }
    } catch(e) {
      //
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: _fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              if(!_fromMe){
                SonaAnalytics.log(DuoSnapEvent.chat_click_duo.name);
              }
              showDialog(context: context, builder: (b){
                return ImagePreview(url: url,targetUrl: widget.otherSide.avatar??'',);
              });
            },
            child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.64,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _fromMe ? Theme.of(context).primaryColor : Colors.transparent,
                    image: DecorationImage(image: CachedNetworkImageProvider(url??''),fit: BoxFit.cover,)
                ),
                foregroundDecoration: _fromMe ? null : BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.all(12),
                clipBehavior: Clip.antiAlias,
                width: 138,
                height: 184,
                // child: url.isNotEmpty?CachedNetworkImage(imageUrl: url??'',width: 138,height: 184,fit: BoxFit.cover,):Container(),
            ),
          ),
        ],
      ),
    );
  }
}