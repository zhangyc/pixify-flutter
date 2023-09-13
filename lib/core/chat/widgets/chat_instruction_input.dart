import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat_mode.dart';
import 'package:sona/core/chat/providers/chat_style.dart';
import 'package:sona/utils/providers/keyboard.dart';

class ChatInstructionInput extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final double? height;
  final String? initialText;
  final TextInputType keyboardType;
  final Function(String)? onInputChange;
  final void Function(String text)? onSubmit;
  final int maxLength;
  final bool autofocus;

  const ChatInstructionInput({
    Key? key,
    this.controller,
    this.height,
    this.initialText,
    this.keyboardType = TextInputType.multiline,
    this.onInputChange,
    this.onSubmit,
    this.maxLength = 30,
    this.autofocus = false
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInstructionInputState();
}

class _ChatInstructionInputState extends ConsumerState<ChatInstructionInput> with AutomaticKeepAliveClientMixin {
  late final TextEditingController _controller;
  late double height;
  Timer? _timer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      _controller.text = widget.initialText!;
    }
    _controller.addListener(_refreshUI);
    FocusManager.instance.primaryFocus?.addListener(_focusNodeListener);
    height = widget.height ?? 38;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.removeListener(_refreshUI);
    _controller.dispose();
    FocusManager.instance.primaryFocus?.removeListener(_focusNodeListener);
    ref.read(keyboardHeightProvider.notifier).update((state) => 0);
    super.dispose();
  }

  void _focusNodeListener() {
    if (!mounted) return;
    if (_timer != null && _timer!.isActive) _timer!.cancel();

    if (FocusManager.instance.primaryFocus?.hasFocus == true) {
      ref.read(keyboardChatStyleVisibleProvider.notifier).update((state) => false);
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (!mounted) return;
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        if (keyboardHeight > 0) {
          ref.read(keyboardMaxHeightProvider.notifier).update((state) => height);
        }
      });
    }

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) return;
      final height = MediaQuery.of(context).viewInsets.bottom;
      ref.read(keyboardHeightProvider.notifier).update((state) => height);
      if (timer.tick == 10) {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final currentChatStyleId = ref.watch(currentChatStyleIdProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (ref.read(inputModeProvider) == InputMode.sona) {
                  ref.read(inputModeProvider.notifier).state = InputMode.manual;
                } else {
                  ref.read(inputModeProvider.notifier).state = InputMode.sona;
                }
              },
              child: Container(
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                child: Text('✍️'),
              )
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 33 - 33 - 16 - 16,
              child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 5,
                  minLines: 1,
                  keyboardAppearance: Brightness.dark,
                  keyboardType: widget.keyboardType,
                  textInputAction: TextInputAction.send,
                  style: Theme.of(context).textTheme.bodySmall,
                  autocorrect: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(height/2),
                    ),
                    prefixIcon: ref.watch(inputModeProvider) == InputMode.sona ? GestureDetector(
                      onTap: _toggleChatStyles,
                      child: Container(
                        width: 33,
                        height: 33,
                        margin: EdgeInsets.symmetric(horizontal: 2.5),
                        decoration: BoxDecoration(
                          image: currentChatStyleId != null ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                ref.read(asyncChatStylesProvider).value!.firstWhere((style) => style.id == currentChatStyleId).icon
                            )
                          ) : null,
                          shape: BoxShape.circle
                        ),
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.center,
                      )
                    ) : null,
                    prefixIconConstraints: BoxConstraints.tightFor(height: height),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                    focusColor: Color(0xFF6D91F4),
                    hintText: ref.watch(inputModeProvider) == InputMode.sona ? 'Tell Sona your intention...' : 'Message',
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).hintColor
                    )
                  ),
                  onChanged: (text) {
                    if (widget.onInputChange != null) widget.onInputChange!(text);
                  },
                  onSubmitted: (String text) {
                    onSubmit(text);
                    FocusManager.instance.primaryFocus?.unfocus();
                    _controller.text = '';
                  },
                  autofocus: widget.autofocus,
              ),
            ),
            TextButton(
                onPressed: () {
                  onSubmit(_controller.text);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Text(ref.watch(inputModeProvider) == InputMode.sona ? 'Sona' : 'Send')
            )
          ],
        ),
        Visibility(
          visible: ref.watch(keyboardChatStyleVisibleProvider),
          child: Container(
            height: ref.watch(keyboardMaxHeightProvider),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            alignment: Alignment.topCenter,
            child: ref.watch(asyncChatStylesProvider).when(
                data: (styles) => GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 3
                  ),
                  children: styles.map<Widget>((s) => GestureDetector(
                    child: Container(
                      color: currentChatStyleId == s.id ? Theme.of(context).colorScheme.secondaryContainer : Colors.transparent,
                        child: Text(s.title)
                    ),
                    onTap: () {
                      ref.read(currentChatStyleIdProvider.notifier).state = s.id;
                      _toggleChatStyles();
                    },
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

  void _toggleChatStyles() {
    ref.read(keyboardChatStyleVisibleProvider.notifier).update((state) {
      if (!state) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      return !state;
    });
  }

  void onSubmit(String text) async {
    if (widget.onSubmit != null) widget.onSubmit!(text);
    _controller.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    ref.invalidate(currentChatStyleIdProvider);
  }

  void _refreshUI() {
    if (mounted) setState(() {});
  }
}