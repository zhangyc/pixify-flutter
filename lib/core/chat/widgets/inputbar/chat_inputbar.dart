import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_style.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/dialog/subsciption.dart';
import 'package:sona/utils/global/global.dart';

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
    this.maxLength = 256,
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
    final currentChatStyle = ref.watch(currentChatStyleProvider(widget.chatId));
    final isMember = ref.watch(myProfileProvider)!.isMember;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: _toggleMode,
              child: Container(
                key: _sonaKey,
                width: 38,
                height: 38,
                padding: EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                child: SonaIcon(
                  icon: ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? SonaIcons.sona_message : SonaIcons.manual_message,
                  size: 32,
                )
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width - 33 - 33 - 16 - 24,
              decoration: BoxDecoration(
                color: ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? Color(0xFFE880F1) : Color(0xFF8D8D8D),
                borderRadius: BorderRadius.circular(_height/2)
              ),
              padding: EdgeInsets.all(1.5),
              child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 5,
                  minLines: 1,
                  keyboardAppearance: Brightness.dark,
                  keyboardType: widget.keyboardType,
                  textInputAction: TextInputAction.send,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                  ),
                  autocorrect: true,
                  cursorWidth: 1.8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(_height/2 - 1),
                    ),
                    // suffixIcon: ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? GestureDetector(
                    //   onTap: _toggleChatStyles,
                    //   child: Container(
                    //     width: 26,
                    //     height: 26,
                    //     margin: EdgeInsets.symmetric(horizontal: 3),
                    //     decoration: BoxDecoration(
                    //       image: currentChatStyle != null ? DecorationImage(
                    //         image: CachedNetworkImageProvider(
                    //           currentChatStyle.icon
                    //         )
                    //       ) : null,
                    //       shape: BoxShape.circle
                    //     ),
                    //     clipBehavior: Clip.antiAlias,
                    //     alignment: Alignment.center,
                    //   )
                    // ) : null,
                    // suffixIconConstraints: BoxConstraints.tight(Size.square(32)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
            SizedBox(width: 4),
            Column(
              children: [
                Visibility(
                  visible: false && ref.watch(hookVisibilityProvider(widget.chatId)),
                  child: SIconButton(
                      onTap: widget.onHookTap,
                      loadingWhenAsyncAction: true,
                      size: 32,
                      indicatorColor: Theme.of(context).primaryColor,
                      child: Container(
                          width: 32,
                          height: 32,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4)
                          ),
                          alignment: Alignment.center,
                          child: Icon(CupertinoIcons.heart_fill, color: Colors.white, size: 24,)
                      )
                  )
                ),
                SizedBox(height: 6),
                Visibility(
                  visible: !ref.watch(currentInputEmptyProvider(widget.chatId)),
                  child: InkWell(
                      onTap: () {
                        onSubmit(_controller.text);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: Icon(
                            Icons.send,
                            size: 24,
                            color: ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? Theme.of(context).primaryColor : Colors.grey),
                      )
                  ),
                ),
                Visibility(
                  visible: ref.watch(currentInputEmptyProvider(widget.chatId)),
                  child: SIconButton(
                      onTap: () {
                        widget.onSuggestionTap();
                        _suggIndicatorEntry?.remove();
                        _suggIndicatorEntry = null;
                      },
                      loadingWhenAsyncAction: true,
                      size: 34,
                      indicatorColor: Colors.black54,
                      child: Container(
                          key: _suggKey,
                          width: 27,
                          height: 34,
                          margin: EdgeInsets.only(bottom: 2),
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          alignment: Alignment.center,
                          child: Icon(CupertinoIcons.sparkles, size: 18, color: Colors.black,)
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
        // Visibility(
        //   visible: ref.watch(chatStylesVisibleProvider(widget.chatId)),
        //   child: Container(
        //     height: ref.watch(softKeyboardHeightProvider),
        //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        //     alignment: Alignment.topCenter,
        //     child: ref.watch(asyncChatStylesProvider).when(
        //         data: (styles) => GridView(
        //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             mainAxisSpacing: 5,
        //             crossAxisSpacing: 5,
        //             childAspectRatio: 3
        //           ),
        //           children: styles.map<Widget>((s) => GestureDetector(
        //             child: Container(
        //               color: currentChatStyle?.id == s.id ? Theme.of(context).colorScheme.secondaryContainer : Color(0x11CCCCCC),
        //               foregroundDecoration: s.memberOnly && !isMember ? BoxDecoration(
        //                 color: Colors.black12
        //               ) : null,
        //               child: Row(
        //                 children: [
        //                   Container(
        //                     width: 33,
        //                     height: 33,
        //                     margin: EdgeInsets.symmetric(horizontal: 2.5),
        //                     decoration: BoxDecoration(
        //                       image: DecorationImage(
        //                         image: CachedNetworkImageProvider(s.icon)
        //                       ),
        //                       shape: BoxShape.circle
        //                     ),
        //                     clipBehavior: Clip.antiAlias,
        //                     alignment: Alignment.center,
        //                   ),
        //                   SizedBox(width: 12),
        //                   Text(s.title, style: Theme.of(context).textTheme.bodySmall),
        //                 ],
        //               )
        //             ),
        //             onTap: () {
        //               if (s.memberOnly && !isMember) {
        //                 showSubscription(FromTag.pay_chat_style);
        //                 SonaAnalytics.log('chat_style_gopay');
        //               } else {
        //                 _setChatStyle(s.id);
        //               }
        //             },
        //           )).toList(),
        //         ),
        //         error: (_, __) => GestureDetector(
        //           child: Center(child: Text('Error, click to retry')),
        //         ),
        //         loading: () => const Center(
        //           child: SizedBox(
        //             width: 36,
        //             height: 36,
        //             child: CircularProgressIndicator(),
        //           ),
        //         )
        //     ),
        //   )
        // )
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
    ref.read(currentChatStyleProvider(widget.chatId).notifier)
        .update((state) => ref.read(asyncChatStylesProvider)
        .value!
        .firstWhere((style) => style.id == id));
    _toggleChatStyles();
  }

  void onSubmit(String text) async {
    if (widget.onSubmit != null) {
      widget.onSubmit!(text);
    }
    _controller.clear();
  }
}