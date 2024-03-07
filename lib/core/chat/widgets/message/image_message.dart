
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

class _MessageWidgetState extends ConsumerState<ImageMessageWidget> {

  late String url='';
  @override
  void initState() {
    try{
      if(widget.message.content!=null&&widget.message.content!.isNotEmpty){
        Map map =  jsonDecode(widget.message.content!);
        url=map['image'];
      }
    }catch(e){

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
                          Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
                        } else if (action == 'delete') {
                          widget.onDelete(widget.message);
                        }
                      },
                      onTap: (){
                        if(!widget.fromMe){
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
                              color: widget.fromMe ? Theme.of(context).primaryColor : Colors.transparent,
                              image: DecorationImage(image: CachedNetworkImageProvider(url??''),fit: BoxFit.cover,)
                          ),
                          foregroundDecoration: widget.fromMe ? null : BoxDecoration(
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