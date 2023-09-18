import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_style.dart';

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
    required this.onSuggestionTap
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
  final Future Function() onSuggestionTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInstructionInputState();
}

class _ChatInstructionInputState extends ConsumerState<ChatInstructionInput> {
  late final TextEditingController _controller;
  late final _focusNode = widget.focusNode ?? FocusNode();
  late final _height = widget.height ?? 38;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController()
      ..text = widget.initialText ?? ''
      ..addListener(_onInputChange);
    _focusNode.addListener(_focusChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onInputChange)
      ..dispose();
    _focusNode
      ..removeListener(_focusChangeListener)
      ..unfocus();
    super.dispose();
  }

  void _focusChangeListener() {
    if (_focusNode.hasFocus) {
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
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                child: Text(
                  ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? 'So\nna': 'Man\nual',
                  softWrap: false,
                  maxLines: 2,
                  style: TextStyle(fontSize: 12, height: 1),
                ),
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width - 33 - 33 - 16 - 16 - 16 - 10,
              decoration: BoxDecoration(
                gradient: ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? const LinearGradient(
                  colors: [
                    Color(0xFFE880F1),
                    Color(0xFFFCD8FF),
                    Color(0xFF2969E9),
                  ],
                ) : null,
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
                  style: Theme.of(context).textTheme.bodySmall,
                  autocorrect: true,
                  cursorWidth: 1.8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(_height/2 - 1),
                    ),
                    suffixIcon: ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? GestureDetector(
                      onTap: _toggleChatStyles,
                      child: Container(
                        width: 33,
                        height: 33,
                        margin: EdgeInsets.symmetric(horizontal: 2.5),
                        decoration: BoxDecoration(
                          image: currentChatStyle != null ? DecorationImage(
                            image: CachedNetworkImageProvider(
                              currentChatStyle.icon
                            )
                          ) : null,
                          shape: BoxShape.circle
                        ),
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.center,
                      )
                    ) : null,
                    suffixIconConstraints: BoxConstraints.tight(Size.square(33)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                    focusColor: Color(0xFF6D91F4),
                    hintText: ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? 'Tell Sona your intention...' : 'Write sth...',
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).hintColor
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
            Visibility(
              visible: !ref.watch(currentInputEmptyProvider(widget.chatId)),
              child: TextButton(
                onPressed: () {
                  onSubmit(_controller.text);
                },
                child: Text(ref.watch(inputModeProvider(widget.chatId)) == InputMode.sona ? 'Sona' : 'Send')
              ),
            ),
            Visibility(
              visible: ref.watch(currentInputEmptyProvider(widget.chatId)),
              child: TextButton(
                  onPressed: widget.onSuggestionTap,
                  child: Text('Sugg')
              ),
            )
          ],
        ),
        Visibility(
          visible: ref.watch(chatStylesVisibleProvider(widget.chatId)),
          child: Container(
            height: ref.watch(softKeyboardHeightProvider),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            alignment: Alignment.topCenter,
            child: ref.watch(asyncChatStylesProvider).when(
                data: (styles) => GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 3
                  ),
                  children: styles.map<Widget>((s) => GestureDetector(
                    child: Container(
                      color: currentChatStyle?.id == s.id ? Theme.of(context).colorScheme.secondaryContainer : Color(0x11CCCCCC),
                      child: Row(
                        children: [
                          Container(
                            width: 33,
                            height: 33,
                            margin: EdgeInsets.symmetric(horizontal: 2.5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(s.icon)
                              ),
                              shape: BoxShape.circle
                            ),
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.center,
                          ),
                          SizedBox(width: 12),
                          Text(s.title, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      )
                    ),
                    onTap: () => _setChatStyle(s.id),
                  )).toList(),
                ),
                error: (_, __) => GestureDetector(
                  child: Center(child: Text('Error, click to retry')),
                ),
                loading: () => const Center(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(),
                  ),
                )
            ),
          )
        )
      ],
    );
  }

  void _toggleMode() {
    ref.read(inputModeProvider(widget.chatId).notifier).update((state) {
      var newMode = state == InputMode.sona ? InputMode.manual : InputMode.sona;
      _controller.clear();
      FirebaseFirestore.instance.collection('users')
          .doc(ref.read(asyncMyProfileProvider).value!.id.toString())
          .collection('rooms').doc(widget.chatId.toString())
          .set({'inputMode': newMode})
          .catchError((_) {});
      return newMode;
    });
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