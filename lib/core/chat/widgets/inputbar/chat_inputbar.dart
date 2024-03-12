import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/widgets/loading_button.dart';
import 'package:sona/utils/global/global.dart';

import '../../../../common/app_config.dart';
import '../../../../common/permission/permission.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/face_detection/detection.dart';
import '../../../../utils/locale/locale.dart';
import '../../../match/providers/duo_provider.dart';
import '../../../match/util/event.dart';
import '../../../match/util/http_util.dart';
import '../../../match/util/image_util.dart';
import '../../../match/widgets/dialogs.dart';
import '../../../subscribe/model/member.dart';
import '../../../subscribe/subscribe_page.dart';
import '../../../widgets/not_meet_conditions.dart';
import '../../../widgets/other_not_meet_conditions.dart';
import 'mode_provider.dart';
ValueNotifier tapBlank=ValueNotifier<String>('');
class ChatInstructionInput extends ConsumerStatefulWidget {
  const ChatInstructionInput({
    Key? key,
    required this.chatId,
    this.controller,
    this.height,
    this.initialText,
    this.keyboardType = TextInputType.multiline,
    this.onInputChange,
    this.onSubmit,
    this.maxLength = 160,
    this.focusNode,
    this.autofocus = false,
    required this.sameLanguage,
    required this.onSuggestionTap,
    required this.onHookTap,
    required this.targetUser,
  }) : super(key: key);

  final int chatId;
  final TextEditingController? controller;
  final double? height;
  final String? initialText;
  final TextInputType keyboardType;
  final Function(String)? onInputChange;
  final void Function(String text)? onSubmit;
  final int maxLength;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool sameLanguage;
  final Future Function() onHookTap;
  final Future Function() onSuggestionTap;
  final UserInfo targetUser;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInstructionInputState();
}

class _ChatInstructionInputState extends ConsumerState<ChatInstructionInput> with RouteAware,WidgetsBindingObserver {
  late final TextEditingController _controller;
  late final _focusNode = widget.focusNode ?? FocusNode();
  late final _height = widget.height ?? 56;
  final _sonaKey = GlobalKey();
  final _suggKey = GlobalKey();
  bool keyboardVisible = false;
  bool openExtend = false;

  static const enterTimesKey = 'enter_times';

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController()
      ..text = widget.initialText ?? ''
      ..addListener(_onInputChange);
    _focusNode.addListener(_focusChangeListener);
    super.initState();
    kvStore.setInt(enterTimesKey, (kvStore.getInt(enterTimesKey) ?? 0) + 1);
    WidgetsBinding.instance.addObserver(this);
    tapBlank.addListener(() {
      if(mounted){
        setState(() {
          openExtend = false;
        });
      }
    });
    //_addOverlay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didChangeMetrics() {
    if(mounted){
      final bottomInset = View.of(context).viewInsets.bottom;
      if(bottomInset>0){
        viewInsetsBottom=MediaQuery.of(context).viewInsets.bottom;
      }
      setState(() {
        keyboardVisible = bottomInset > 0;

        // if (isKeyboardVisible) {
        //   openExtend = false; // Hide options when keyboard is visible
        // }

      });
    }

    super.didChangeMetrics();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    routeObserver.unsubscribe(this);
    _controller
      ..removeListener(_onInputChange)
      ..dispose();
    _focusNode
      ..removeListener(_focusChangeListener)
      ..unfocus();
    super.dispose();
  }

  @override
  void didPop() {
    _removeOverlay();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    _removeOverlay();
    super.didPushNext();
  }

  void _addOverlay() {
    final enterTimes = kvStore.getInt(enterTimesKey);
    if (enterTimes == 1) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _showSonaIndicator();
      });
    } else if (enterTimes == 2) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _showSuggIndicator();
      });
    }
  }

  void _removeOverlay() {
    _sonaIndicatorEntry?.remove();
    _sonaIndicatorEntry = null;
    _suggIndicatorEntry?.remove();
    _suggIndicatorEntry = null;
  }

  void _focusChangeListener() {
    if (_focusNode.hasFocus) {
      _removeOverlay();
      ref.read(chatStylesVisibleProvider(widget.chatId).notifier).update((state) => false);
    }
    if(_focusNode.hasFocus){
      if(mounted){
        setState(() {
          keyboardVisible=false;
        });
      }
    }
  }

  void _onInputChange() {
    final mode = ref.read(inputModeProvider(widget.chatId));
    if (mode == InputMode.sona) {
      ref.read(sonaInputProvider(widget.chatId).notifier).update((state) => _controller.text);
    } else {
      ref.read(manualInputProvider(widget.chatId).notifier).update((state) => _controller.text);
    }
  }
  bool detecting=false;

  @override
  Widget build(BuildContext context) {
    // final currentChatStyle = ref.watch(currentChatStyleProvider(widget.chatId));
    // final isMember = ref.watch(myProfileProvider)!.isMember;
    final myL = findMatchedSonaLocale(ref.read(myProfileProvider)!.locale!);
    final myLocale = Locale.fromSubtags(languageCode: myL.locale.languageCode, scriptCode: myL.locale.scriptCode, countryCode: myL.locale.countryCode);
    final hintText = widget.sameLanguage
        ? S.of(context).speakSameLanguage
        : ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona
            ? S.of(context).justTypeInYourLanguage(myL.displayName)
            : S.of(context).sonaInterpretationOff;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          // height: _height,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  GestureDetector(
                      onTap:(){
                        ///点击
                        if(keyboardVisible){
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        if(mounted){
                          setState(() {
                            openExtend=true;
                          });
                        }
                        // isKeyboardVisible=false;

                      },
                      child:  SvgPicture.asset(Assets.svgExtend,width: 56,height: 56,)
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      // width: MediaQuery.of(context).size.width - 33 - 33 - 16 - 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 1.5),
                      child: TextField(
                        onTapOutside: (cv){
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            openExtend=false;
                          });
                        },
                        controller: _controller,
                        focusNode: _focusNode,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 5,
                        minLines: 1,
                        maxLength: widget.maxLength,
                        buildCounter: (BuildContext _, {required int currentLength, required bool isFocused, required int? maxLength}) => null,
                        keyboardAppearance: Brightness.dark,
                        keyboardType: widget.keyboardType,
                        textInputAction: TextInputAction.newline,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          locale: myLocale
                        ),
                        autocorrect: true,
                        cursorWidth: 1.8,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Color(0xFF6D91F4),
                          hintText: hintText,
                          hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w500
                          )
                        ),
                        onChanged: (text) {
                          if (widget.onInputChange != null) widget.onInputChange!(text);
                        },
                        onSubmitted: (String text) {
                          if (text.isEmpty) return;
                          onSubmit(text);
                          _controller.text = '';
                        },
                        autofocus: widget.autofocus,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Visibility(
                    visible: !ref.watch(currentInputEmptyProvider(widget.chatId)),
                    child: Container(
                      margin: EdgeInsets.all(1),
                      child: IconButton(
                        iconSize: 56,
                        padding: EdgeInsets.all(14),
                        onPressed: () {
                          if (_controller.text.isEmpty) return;
                          onSubmit(_controller.text);
                          _controller.text = '';
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).primaryColor
                          ),
                          shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))
                          )
                        ),
                        icon: SonaIcon(icon: SonaIcons.chat_send)
                      ),
                    ),
                  ),
                ],
              ),
              keyboardVisible?Container():Visibility(
                visible: openExtend,
                child: Padding(padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(child: GestureDetector(
                        onTap: widget.onSuggestionTap,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffF6F3F3),
                              borderRadius: BorderRadius.circular(24)
                          ),
                          height: 242,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.iconsSonaMessage,height: 48,width: 48,),
                              Text('Give me advice',style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff2c2c2c),
                                  fontWeight: FontWeight.w900
                              ),
                              )
                            ],
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(child: GestureDetector(
                        child: detecting?Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffF6F3F3),
                                borderRadius: BorderRadius.circular(24)
                            ),
                            height: 242,
                            child: SizedBox(
                              height: 32,
                              width: 32,
                              child: CircularProgressIndicator(),
                            )
                        ):Container(
                          decoration: BoxDecoration(
                              color: Color(0xffF6F3F3),
                              borderRadius: BorderRadius.circular(24)
                          ),
                          height: 242,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Assets.svgChatDuosnap,height: 48,width: 48,),
                              Text(S.current.duoSnap,style: const TextStyle(
                                  color: Color(0xff2c2c2c),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900
                              ),)
                            ],
                          ),
                        ),
                        onTap: ()async{
                          if(!canDuoSnap){

                            duosnap-=1;
                            if(ref.read(myProfileProvider)!.memberType==MemberType.none){
                              SonaAnalytics.log(DuoSnapEvent.Duo_click_pay.name);
                              Navigator.push(context, MaterialPageRoute(builder:(c){
                                return const SubscribePage(fromTag: FromTag.duo_snap,);
                              }));
                            }else if(ref.read(myProfileProvider)!.memberType==MemberType.club){
                              SonaAnalytics.log(DuoSnapEvent.plus_duo_limit.name);

                              Navigator.push(context, MaterialPageRoute(builder:(c){
                                return const SubscribePage(fromTag: FromTag.pay_match_arrow,);
                              }));
                            }else if(ref.read(myProfileProvider)!.memberType==MemberType.plus){
                              SonaAnalytics.log(DuoSnapEvent.club_clickduo_payplus.name);

                              Fluttertoast.showToast(msg: S.current.weeklyLimitReached);
                            }
                            return;
                          }
                          try{
                            detecting=true;
                            HttpResult result=await post('/merge-photo/find-last');
                            if(result.statusCode.toString()=='60010') {
                              setState(() {

                              });
                              FileInfo file=await DefaultCacheManager().downloadFile(ref.read(myProfileProvider)!.photos.first.url);
                              FileInfo file2=await DefaultCacheManager().downloadFile(widget.targetUser.avatar??'');

                              bool con1=await faceDetection(file.file.path);
                              bool con2=await faceDetection(file2.file.path);
                              detecting=false;
                              setState(() {

                              });
                              if(con1&&con2){
                                SdModel? sdModel=await showDuoSnapDialog(context,target:MatchUserInfo.fromUserInfoInstance(widget.targetUser));

                              }else if(!con1&&con2){
                                SonaAnalytics.log(DuoSnapEvent.notreal_self.name);

                                showDuoSnapTip(context, child: NotMeetConditions(
                                  close: (){
                                    Navigator.pop(context);
                                  },
                                  camera: () async {
                                    setUserAvatarPhoto(ImageSource.camera, ref);
                                    if(mounted){
                                      Navigator.pop(context);
                                    }
                                  },
                                  gallery: () async {
                                    setUserAvatarPhoto(ImageSource.gallery, ref);
                                    if(mounted){
                                      Navigator.pop(context);
                                    }
                                  },
                                  anyway: () async{
                                    if(mounted){
                                      Navigator.pop(context);
                                    }
                                    SdModel? sdModel=await showDuoSnapDialog(context,target: MatchUserInfo.fromUserInfoInstance(widget.targetUser));

                                  },
                                ),
                                    dialogHeight: 361);
                              }else if(con1&&!con2){
                                SonaAnalytics.log(DuoSnapEvent.notreal_other.name);

                                showDuoSnapTip(context, child: OtherNotMeetConditions(
                                  close: (){
                                    Navigator.pop(context);
                                  },
                                  gotit: (){
                                    Navigator.pop(context);
                                  },
                                  sendDM: (){
                                    Future.delayed(Duration(milliseconds: 200),(){
                                      if(canArrow){
                                        showDm(context, MatchUserInfo.fromUserInfoInstance(widget.targetUser),(){});
                                      }else {
                                        bool isMember=ref.read(myProfileProvider)?.isMember??false;
                                        if(isMember){
                                          Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                                        }else{
                                          Navigator.push(context, MaterialPageRoute(builder:(c){
                                            return SubscribePage(fromTag: FromTag.duo_snap,);
                                          }));
                                        }
                                      }
                                    });
                                    if(mounted){
                                      Navigator.pop(context);
                                    }
                                  }, anyway: () async{
                                  Navigator.pop(context);

                                  SdModel? sdModel=await showDuoSnapDialog(context,target: MatchUserInfo.fromUserInfoInstance(widget.targetUser));

                                },

                                ), dialogHeight: 390);
                              }else if(!con1&&!con2){
                                showDuoSnapTip(context, child: NotMeetConditions(
                                  close: (){
                                    Navigator.pop(context);
                                  },
                                  camera: () async {
                                    setUserAvatarPhoto(ImageSource.camera, ref);
                                    if(mounted){
                                      Navigator.pop(context);
                                    }
                                  },
                                  gallery: () async {
                                    setUserAvatarPhoto(ImageSource.gallery, ref);
                                    if(mounted){
                                      Navigator.pop(context);
                                    }
                                  }, anyway: ()async{
                                  if(mounted){
                                    Navigator.pop(context);
                                  }
                                  SdModel? sdModel=await showDuoSnapDialog(context,target: MatchUserInfo.fromUserInfoInstance(widget.targetUser));

                                },
                                ), dialogHeight: 361);
                              }

                            }else {
                              Fluttertoast.showToast(msg: S.current.onlyOneAtatime);
                              detecting=false;
                              setState(() {

                              });
                            }
                          }catch(e){
                            detecting=false;
                            setState(() {

                            });
                          }
                        }

                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  OverlayEntry? _sonaIndicatorEntry;
  void _showSonaIndicator() {
    final renderBox = _sonaKey.currentContext!.findRenderObject() as RenderBox?;
    Offset offset = renderBox!.localToGlobal(Offset.zero);
    _sonaIndicatorEntry = OverlayEntry(builder: (_) => Positioned(
      top: offset.dy - 46,
      left: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sona Mode: Sona will spice up your messages!',
            style: TextStyle(fontSize: 10, color: Theme.of(context).primaryColor),
          ),
          SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Image.asset('assets/images/magic_indicator.png', height: 30),
          ),
        ],
      )
    ));
    Overlay.of(context).insert(_sonaIndicatorEntry!);
  }

  OverlayEntry? _suggIndicatorEntry;
  void _showSuggIndicator() {
    final renderBox = _suggKey.currentContext!.findRenderObject() as RenderBox?;
    Offset offset = renderBox!.localToGlobal(Offset.zero);
    _suggIndicatorEntry = OverlayEntry(builder: (_) => Positioned(
        top: offset.dy - 54,
        right: 28,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Get stuck? Sona got some good ideas!',
              style: TextStyle(fontSize: 10, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset('assets/images/magic_indicator.png', height: 30),
            ),
          ],
        )
    ));
    Overlay.of(context).insert(_suggIndicatorEntry!);
  }

  void _toggleMode() {
    ref.read(inputModeProvider(widget.chatId).notifier).update((state) {
      var newMode = state == InputMode.sona ? InputMode.manual : InputMode.sona;
      _controller.clear();
      FirebaseFirestore.instance.collection('${env.firestorePrefix}_users')
          .doc(ref.read(myProfileProvider)!.id.toString())
          .collection('rooms').doc(widget.chatId.toString())
          .set({'inputMode': newMode})
          .catchError((_) {});
      return newMode;
    });
    _sonaIndicatorEntry?.remove();
    _sonaIndicatorEntry = null;
  }

  void _toggleChatStyles() {
    ref.read(chatStylesVisibleProvider(widget.chatId).notifier).update((state) {
      if (!state) {
        _focusNode.unfocus();
      } else {
        _focusNode.requestFocus();
      }
      return !state;
    });
    SonaAnalytics.log('chat_style');
  }

  void _setChatStyle(int id) {
    // ref.read(currentChatStyleProvider(widget.chatId).notifier)
    //     .update((state) => ref.read(asyncChatStylesProvider)
    //     .value!
    //     .firstWhere((style) => style.id == id));
    // _toggleChatStyles();
  }

  void onSubmit(String text) async {
    if (widget.onSubmit != null) {
      widget.onSubmit!(text);
    }
  }
}
enum KeyBoardType{
  extend,
  system
}