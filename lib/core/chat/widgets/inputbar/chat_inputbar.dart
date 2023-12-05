import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/utils/global/global.dart';

import '../../../../utils/locale/locale.dart';
import 'mode_provider.dart';

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
    required this.onSuggestionTap,
    required this.onHookTap
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
  final Future Function() onHookTap;
  final Future Function() onSuggestionTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInstructionInputState();
}

class _ChatInstructionInputState extends ConsumerState<ChatInstructionInput> with RouteAware {
  late final TextEditingController _controller;
  late final _focusNode = widget.focusNode ?? FocusNode();
  late final _height = widget.height ?? 38;
  final _sonaKey = GlobalKey();
  final _suggKey = GlobalKey();

  static const enterTimesKey = 'enter_times';

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController()
      ..text = widget.initialText ?? ''
      ..addListener(_onInputChange);
    _focusNode.addListener(_focusChangeListener);
    super.initState();
    kvStore.setInt(enterTimesKey, (kvStore.getInt(enterTimesKey) ?? 0) + 1);
    _addOverlay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
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
    Locale? myLocale;
    if (ref.read(myProfileProvider)!.locale != null) {
      final myL = findMatchedSonaLocale(ref.read(myProfileProvider)!.locale!).locale;
      myLocale = Locale.fromSubtags(languageCode: myL.languageCode, scriptCode: myL.scriptCode, countryCode: myL.countryCode);
    }
    if (kDebugMode) print('my locale in input_bar: ${myLocale?.toLanguageTag()}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: widget.onSuggestionTap,
                child: Container(
                  key: _sonaKey,
                  width: 38,
                  height: 56,
                  padding: EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  child: SonaIcon(
                    icon: SonaIcons.sona_message,
                    size: 24,
                  )
                )
              ),
              Expanded(
                child: Container(
                  // width: MediaQuery.of(context).size.width - 33 - 33 - 16 - 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_height/4)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.5),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    maxLines: 5,
                    minLines: 1,
                    maxLength: widget.maxLength,
                    buildCounter: (BuildContext, {required int currentLength, required bool isFocused, required int? maxLength}) => null,
                    keyboardAppearance: Brightness.dark,
                    keyboardType: widget.keyboardType,
                    textInputAction: TextInputAction.newline,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      locale: myLocale
                    ),
                    autocorrect: true,
                    cursorWidth: 1.8,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.6),
                        borderRadius: BorderRadius.circular(_height/4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.6),
                        borderRadius: BorderRadius.circular(_height/4),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Color(0xFF6D91F4),
                      hintText: ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? 'Tell Sona your intention...' : 'Write sth...',
                      hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    onChanged: (text) {
                      if (widget.onInputChange != null) widget.onInputChange!(text);
                    },
                    onSubmitted: (String text) {
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
                      onSubmit(_controller.text);
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
    _controller.clear();
  }
}