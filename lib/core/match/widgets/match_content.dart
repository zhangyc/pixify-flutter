import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import 'package:sona/core/match/widgets/avatar_animation.dart';

class MatchedContent extends StatefulWidget {
  const MatchedContent({super.key, required this.target, required this.next});
  final MatchUserInfo target;
  final VoidCallback next;
  @override
  State<MatchedContent> createState() => _MatchedContentState();
}

class _MatchedContentState extends State<MatchedContent> {
  TextEditingController controller=TextEditingController();
  var image=AssetImage(Assets.apngMatchBgAnim,);
  late Timer timer;
  int _secondsRemaining = 1160;

  @override
  void initState() {
    controller.addListener(() {
      setState((){

      });
    });
    Future.delayed(Duration(milliseconds: 1200),(){
      image.evict();
      image=AssetImage(Assets.imagesMatchImageBg);
      setState(() {

      });
    });
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    // timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(image:image,fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Consumer(builder: (b,ref,_){

            return Container(
                height: MediaQuery.of(context).size.height,
                // color: Colors.white.withOpacity(0.8),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(
                          right: 16
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          widget.next.call();
                        },
                        child: Image.asset(Assets.iconsSkip,width: 40,height: 40,),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(S.current.newMatch,style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900
                    ),),
                    const SizedBox(
                      height: 16,
                    ),
                    AvatarAnimation(
                      avatar: widget.target.avatar??'',
                      name: widget.target.name??'',
                      direction: AnimationDirection.left,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Text.rich(
                        TextSpan(text: '"',style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 28
                        ),
                            children: [
                              TextSpan(
                                text:widget.target.likeActivityName != null && widget.target.likeActivityName!.isNotEmpty ? S.of(context).imVeryInterestedInSomething(widget.target.likeActivityName!) : S.of(context).youSeemCool,
                                style: TextStyle(
                                    color: Color(0xff2c2c2c),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20
                                ),
                              ),
                              TextSpan(
                                text: '"',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 28

                                ),
                              ),
                            ]
                        ),

                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: TextField(
                            onTapOutside: (cv){
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            // keyboardType: TextInputType.multiline,
                            // maxLines: null,
                            // minLines: 1,
                            controller: controller,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(160), // Maximum length of 10 characters
                            ],
                            decoration: InputDecoration(
                              hintText: S.of(context).wannaHollaAt,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16
                              ),
                              border:OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2
                                  ),
                                  borderRadius: BorderRadius.circular(24)
                              ),
                            ),
                          ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          controller.text.isNotEmpty?GestureDetector(
                            child: Image.asset(Assets.iconsSend,width: 56,height: 56,),
                            onTap: (){
                              if(controller.text.isEmpty){
                                return ;
                              }
                              widget.next.call();
                              ///匹配成功，发送消息
                              MatchApi.customSend(widget.target.id,controller.text);
                              Navigator.pop(context);
                            },
                          ):Container(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      onPressed: (){
                        ///发送一个快捷的sona打招呼
                        widget.next.call();
                        MatchApi.sayHi(widget.target.id,'matched');
                        SonaAnalytics.log(MatchEvent.match_popup_sona.name);
                        Navigator.pop(context);

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.iconsLogo,width: 20,height: 20,),
                          Text('${S.current.letSONASayHiForYou}',style: TextStyle(
                              color: Color(0xff2c2c2c),
                              fontSize: 16,
                              fontWeight: FontWeight.w800
                          ),),
                          const Icon(Icons.arrow_forward_outlined)
                        ],
                      ),
                    )
                  ],
                )
            );
          }),
        ),
      ),
    );
  }
}