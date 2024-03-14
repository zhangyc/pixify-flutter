import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/models/text_message.dart';
import 'package:sona/core/chat/widgets/voice_message_recorder.dart';
import 'package:sona/utils/global/global.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/dialog/common.dart';
import '../../../../utils/locale/locale.dart';
import '../tips_dialog.dart';
import 'mode_provider.dart';

class ChatInstructionInput extends ConsumerStatefulWidget {
  const ChatInstructionInput({
    Key? key,
    required this.chatId,
    required this.sameLanguage,
    required this.onSendMessage
  }) : super(key: key);

  final int chatId;
  final bool sameLanguage;
  final Future Function(Map<String, dynamic>) onSendMessage;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInstructionInputState();
}

class _ChatInstructionInputState extends ConsumerState<ChatInstructionInput> with RouteAware {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final _sonaKey = GlobalKey();
  final _suggKey = GlobalKey();
  OverlayEntry? _voiceEntry;
  final _stopwatch = Stopwatch();
  Timer? _timer;

  static const enterTimesKey = 'enter_times';
  static final recorder = AudioRecorder();
  static const config = RecordConfig(
    encoder: AudioEncoder.aacLc,
    bitRate: 64000,
    sampleRate: 8000,
    numChannels: 1,
  );

  @override
  void initState() {
    _controller = TextEditingController()..addListener(_onInputChange);
    _focusNode = FocusNode()..addListener(_focusChangeListener);
    super.initState();
    kvStore.setInt(enterTimesKey, (kvStore.getInt(enterTimesKey) ?? 0) + 1);
    //_addOverlay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
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
  }

  void _onInputChange() {
    final mode = ref.read(inputModeProvider(widget.chatId));
    if (mode == InputMode.sona) {
      ref.read(sonaInputProvider(widget.chatId).notifier).update((state) => _controller.text);
    } else {
      ref.read(manualInputProvider(widget.chatId).notifier).update((state) => _controller.text);
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
          // height: _height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _onTipsTap,
                child: Container(
                  key: _sonaKey,
                  // width: 24,
                  // height: 24,
                  margin: EdgeInsets.only(top: 18, bottom: 18, right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Color(0xFFE8E6E6), width: 1))
                  ),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  child: SonaIcon(
                    icon: SonaIcons.sona_message,
                    size: 24,
                  )
                )
              ),
              if (ref.watch(inputMethodProvider(widget.chatId)) == InputMethod.keyboard) Expanded(
                child: Container(
                  // width: MediaQuery.of(context).size.width - 33 - 33 - 16 - 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.5),
                  child: TextField(
                    onTapOutside: (cv){
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
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
              )
              else Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
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
                      Fluttertoast.showToast(msg: 'Permission is required!');
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
                    final _voicePath = await recorder.stop();
                    if (_voicePath == null) return;
                    widget.onSendMessage({
                      'type': ImMessageContentType.audio,
                      'duration': _stopwatch.elapsedMilliseconds / 1000.0,
                      'localExtension': {
                        'path': _voicePath,
                      }
                    });
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1.5)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.5),
                    alignment: Alignment.center,
                    child: Text('Hold to speak', style: Theme.of(context).textTheme.titleMedium),
                  ),
                )
              ),
              SizedBox(width: 4),
              if (ref.watch(currentInputEmptyProvider(widget.chatId))) Container(
                width: 56,
                height: 56,
                margin: EdgeInsets.all(1),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: GestureDetector(
                    onTap: () {
                      ref.watch(inputMethodProvider(widget.chatId).notifier)
                        .update((state) => state == InputMethod.voice
                          ? InputMethod.keyboard
                          : InputMethod.voice);
                    },
                    child: Icon(ref.read(inputMethodProvider(widget.chatId)) == InputMethod.keyboard ? Icons.keyboard_voice : Icons.keyboard_alt, size: 28, color: Colors.white)
                ),
              )
              else Container(
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
                      ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))
                    )
                  ),
                  icon: SonaIcon(icon: SonaIcons.chat_send, size: 28)
                ),
              ),
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
}