import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/models/text_message.dart';
import 'package:sona/core/chat/providers/audio.dart';
import 'package:sona/core/chat/widgets/message/audio_message_controls.dart';
import 'package:sona/core/chat/widgets/voice_message_recorder.dart';
import 'package:sona/utils/global/global.dart';

import '../../../../common/models/user.dart';
import '../../../../common/permission/permission.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/dialog/common.dart';
import '../../../../utils/face_detection/detection.dart';
import '../../../../utils/locale/locale.dart';
import '../../../match/bean/match_user.dart';
import '../../../match/util/event.dart';
import '../../../match/util/http_util.dart';
import '../../../match/util/image_util.dart';
import '../../../match/widgets/dialogs.dart';
import '../../../subscribe/model/member.dart';
import '../../../subscribe/subscribe_page.dart';
import '../../../widgets/not_meet_conditions.dart';
import '../../../widgets/other_not_meet_conditions.dart';
import '../tips_dialog.dart';
import 'mode_provider.dart';

class ChatInstructionInput extends ConsumerStatefulWidget {
  const ChatInstructionInput({
    Key? key,
    required this.chatId,
    required this.otherInfo,
    required this.sameLanguage,
    required this.onSendMessage
  }) : super(key: key);

  final int chatId;
  final UserInfo otherInfo;
  final bool sameLanguage;
  final Future Function(Map<String, dynamic>) onSendMessage;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInstructionInputState();
}

class _ChatInstructionInputState extends ConsumerState<ChatInstructionInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  OverlayEntry? _voiceEntry;
  final _stopwatch = Stopwatch();
  Timer? _timer;
  bool detecting = false;

  static const enterTimesKey = 'enter_times';
  static final recorder = AudioRecorder();
  static const config = RecordConfig(
    encoder: AudioEncoder.aacLc,
    bitRate: 32000,
    sampleRate: 16000,
    numChannels: 1,
    device: null,
    autoGain: false,
    echoCancel: false,
    noiseSuppress: true
  );

  @override
  void initState() {
    _controller = TextEditingController()..addListener(_onInputChange);
    _focusNode = FocusNode()..addListener(_focusListener);
    super.initState();
    kvStore.setInt(enterTimesKey, (kvStore.getInt(enterTimesKey) ?? 0) + 1);
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    _controller
      ..removeListener(_onInputChange)
      ..dispose();
    super.dispose();
  }

  void _onInputChange() {
    final mode = ref.read(inputModeProvider(widget.chatId));
    if (mode == InputMode.sona) {
      ref.read(sonaInputProvider(widget.chatId).notifier).update((state) => _controller.text);
    } else {
      ref.read(manualInputProvider(widget.chatId).notifier).update((state) => _controller.text);
    }
  }

  void _focusListener() {
    if (_focusNode.hasFocus) {
      ref.read(keyboardExtensionVisibilityProvider.notifier).update((state) => true);
      Future.delayed(const Duration(milliseconds: 500),
          () => ref.read(softKeyboardHeightProvider.notifier)
              .update((state) => max(state, MediaQuery.of(context).viewInsets.bottom))
      );
      Future.delayed(const Duration(milliseconds: 1000),
              () => ref.read(softKeyboardHeightProvider.notifier)
              .update((state) => max(state, MediaQuery.of(context).viewInsets.bottom))
      );
    } else {
      Future.delayed(const Duration(milliseconds: 500),
              () => ref.read(paddingBottomHeightProvider.notifier)
              .update((state) => max(state, MediaQuery.of(context).padding.bottom))
      );
    }
  }

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
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (ref.watch(keyboardExtensionVisibilityProvider)) GestureDetector(
                onTap: () {
                  ref.read(keyboardExtensionVisibilityProvider.notifier).update((state) {
                    if (_focusNode.hasFocus) {
                      _focusNode.unfocus();
                    }
                    return false;
                  });
                },
                child: Container(
                  width: 54,
                  height: 54,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  child: SonaIcon(
                    icon: SonaIcons.close,
                    size: 24,
                  )
                )
              )
              else GestureDetector(
                  onTap: () {
                    ref.read(keyboardExtensionVisibilityProvider.notifier).update((state) {
                        return true;
                    });
                  },
                  child: Container(
                      width: 54,
                      height: 54,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      clipBehavior: Clip.antiAlias,
                      alignment: Alignment.center,
                      child: Icon(Icons.add, size: 24)
                  )
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  // width: MediaQuery.of(context).size.width - 33 - 33 - 16 - 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.5),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 5,
                    minLines: 1,
                    maxLength: 160,
                    buildCounter: (BuildContext _, {required int currentLength, required bool isFocused, required int? maxLength}) => null,
                    keyboardAppearance: Brightness.dark,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      locale: myLocale
                    ),
                    // onTapOutside: (_) {
                    //   if (_focusNode.hasFocus) _focusNode.unfocus();
                    //   ref.read(keyboardExtensionVisibilityProvider.notifier).update((state) => false);
                    // },
                    autocorrect: true,
                    cursorWidth: 1.8,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
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
                    onSubmitted: (String text) {
                      final trimmedText = text.trim();
                      if (trimmedText.isEmpty) return;
                      final needsTranslation = ref.read(inputModeProvider(widget.chatId)) == InputMode.sona;
                      widget.onSendMessage(TextMessage.buildContent(trimmedText, needsTranslation));
                      _controller.clear();
                    },
                    autofocus: false,
                  ),
                ),
              ),
              SizedBox(width: 4),
              if (ref.watch(currentInputEmptyProvider(widget.chatId))) Container(
                width: 76,
                height: 56,
                margin: EdgeInsets.all(1),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onLongPressStart: (_) async {
                    if (await Permission.microphone.request().isGranted) {
                      _stopwatch.reset();
                      _stopwatch.start();
                      _timer = Timer(const Duration(seconds: 60), () async {
                        _stopwatch.stop();
                        final _voicePath = await recorder.stop();
                        if (_voicePath == null) return;
                        widget.onSendMessage({
                          'type': ImMessageContentType.audio,
                          'duration': 60.0,
                          'localExtension': {
                            'path': _voicePath,
                          }
                        });
                        _voiceEntry?.remove();
                      });
                      recorder.start(config, path: ((await getTemporaryDirectory()).path + '/' + DateTime.now().millisecondsSinceEpoch.toString() + '.m4a'));
                    } else {
                      Fluttertoast.showToast(msg: 'Microphone permission is required!');
                      return;
                    }
                    _voiceEntry = OverlayEntry(builder: (_) => VoiceMessageRecorder());
                    Overlay.of(context).insert(_voiceEntry!);
                  },
                  onLongPressEnd: (_) async {
                    _voiceEntry?.remove();
                    _stopwatch.stop();
                    _timer?.cancel();
                    if (_stopwatch.elapsedMilliseconds < 500) return;
                    final path = await recorder.stop();
                    if (path == null) return;

                    final player = ref.read(audioPlayerProvider(widget.chatId));
                    ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => null);
                    await player.setSourceDeviceFile(path);
                    var duration = await player.getDuration();
                    await player.release();
                    duration ??= _stopwatch.elapsed;
                    widget.onSendMessage({
                      'type': ImMessageContentType.audio,
                      'duration': duration.inMilliseconds / 1000.0,
                      'localExtension': {
                        'path': path,
                      }
                    });
                  },
                  child: Icon(CupertinoIcons.mic, size: 28, color: Colors.white)
                ),
              )
              else Container(
                width: 76,
                margin: EdgeInsets.all(1),
                child: IconButton(
                  iconSize: 56,
                  padding: EdgeInsets.all(14),
                  onPressed: () {
                    final trimmedText = _controller.text.trim();
                    if (trimmedText.isEmpty) return;
                    final needsTranslation = ref.read(inputModeProvider(widget.chatId)) == InputMode.sona;
                    widget.onSendMessage(TextMessage.buildContent(trimmedText, needsTranslation));
                    _controller.clear();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    )
                  ),
                  icon: SonaIcon(icon: SonaIcons.chat_send, size: 28)
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.ease,
          height: ref.watch(keyboardExtensionVisibilityProvider) ? ref.watch(softKeyboardHeightProvider) : ref.watch(paddingBottomHeightProvider),
          child: Container(
            clipBehavior: Clip.antiAlias,
            foregroundDecoration: BoxDecoration(
              color: ref.watch(keyboardExtensionVisibilityProvider) ? Colors.transparent : Colors.white
            ),
            decoration: BoxDecoration(),
            child: Padding(padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _onTipsTap,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffF6F3F3),
                            borderRadius: BorderRadius.circular(24)
                        ),
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
                    )
                  ),
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
                        if (!canDuoSnap){
                          duosnap -=1 ;
                          switch(ref.read(myProfileProvider)!.memberType) {
                            case MemberType.none:
                              SonaAnalytics.log(
                                  DuoSnapEvent.Duo_click_pay.name);
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (c) {
                                return const SubscribePage(
                                  fromTag: FromTag.duo_snap,);
                              }));
                              break;
                            case MemberType.club:
                              SonaAnalytics.log(
                                  DuoSnapEvent.plus_duo_limit.name);
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (c) {
                                return const SubscribePage(
                                  fromTag: FromTag.pay_match_arrow,);
                              }));
                              break;
                            case MemberType.plus:
                              SonaAnalytics.log(
                                  DuoSnapEvent.club_clickduo_payplus.name);
                              Fluttertoast.showToast(
                                  msg: S.current.weeklyLimitReached);
                              break;
                          }
                          return;
                        }
                        try {
                          detecting = true;
                          HttpResult result = await post('/merge-photo/find-last');
                          if (result.statusCode.toString() == '60010') {
                            if (mounted) setState(() {});
                            final file=await DefaultCacheManager().downloadFile(ref.read(myProfileProvider)!.photos.first.url);
                            final file2=await DefaultCacheManager().downloadFile(widget.otherInfo.avatar??'');

                            bool isHumanFace1 = await faceDetection(file.file.path);
                            bool isHumanFace2 = await faceDetection(file2.file.path);
                            detecting = false;
                            if (mounted) setState(() {});
                            if (isHumanFace1 && isHumanFace2) {
                              final sdModel=await showDuoSnapDialog(context, target:MatchUserInfo.fromUserInfoInstance(widget.otherInfo));
                            } else if (!isHumanFace1&&isHumanFace2) {
                              SonaAnalytics.log(DuoSnapEvent.notreal_self.name);
                              if (!mounted) return;
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
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                  final sdModel = await showDuoSnapDialog(context,target: MatchUserInfo.fromUserInfoInstance(widget.otherInfo));
                                },
                              ),
                              dialogHeight: 361
                              );
                            } else if (isHumanFace1 && !isHumanFace2){
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
                                    if (canArrow){
                                      showDm(context, MatchUserInfo.fromUserInfoInstance(widget.otherInfo),(){});
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
                                final sdModel=await showDuoSnapDialog(context,target: MatchUserInfo.fromUserInfoInstance(widget.otherInfo));
                              },

                              ),
                              dialogHeight: 390
                              );
                            } else if (!isHumanFace1&&!isHumanFace2){
                              showDuoSnapTip(context, child: NotMeetConditions(
                                close: () {
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
                                final sdModel=await showDuoSnapDialog(context,target: MatchUserInfo.fromUserInfoInstance(widget.otherInfo));
                              },
                              ), dialogHeight: 361);
                            }

                          } else {
                            Fluttertoast.showToast(msg: S.current.onlyOneAtatime);
                            setState(() {
                              detecting = false;
                            });
                          }
                        } catch(e) {
                          detecting = false;
                          setState(() {
                          });
                        }
                      }

                  ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future _onTipsTap() async {
    showCommonBottomSheet(
        context: context,
        title: 'SONA Tips',
        actions: [
          SonaTipsDialog(userId: widget.chatId)
        ]
    );
    SonaAnalytics.log('chat_suggest');
  }
}

final keyboardExtensionVisibilityProvider = StateProvider<bool>((ref) => false);