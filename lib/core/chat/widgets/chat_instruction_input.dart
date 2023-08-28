import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/text/gradient_colored_text.dart';
import 'package:sona/core/chat/providers/chat_style.dart';

class ChatInstructionInput extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  final double? height;
  final String? initialText;
  final String hintText;
  final TextInputType keyboardType;
  final String actionText;
  final Function(String)? onInputChange;
  final void Function(String? text)? onSubmit;
  final int maxLength;
  final FocusNode? focusNode;
  final bool autofocus;

  const ChatInstructionInput({
    Key? key,
    this.controller,
    this.height,
    this.initialText,
    this.hintText = 'Just give me a word',
    this.keyboardType = TextInputType.text,
    this.actionText = 'Sona',
    this.onInputChange,
    this.onSubmit,
    this.maxLength = 30,
    this.focusNode,
    this.autofocus = false
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInstructionInputState();
}

class _ChatInstructionInputState extends ConsumerState<ChatInstructionInput> with AutomaticKeepAliveClientMixin {
  late final TextEditingController _controller;
  late FocusNode focusNode;
  late double height;
  bool _chatStylesVisible = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      _controller.text = widget.initialText!;
    }
    _controller.addListener(_refreshUI);
    focusNode = widget.focusNode ?? FocusNode();
    height = widget.height ?? 70;
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_refreshUI);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentChatStyleId = ref.watch(currentChatStyleIdProvider);

    super.build(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              GradientColoredText(
                  text: 'S',
                  style: TextStyle(fontSize: 16)
              ),
              SizedBox(width: 6),
              Text(
                  'What you wanna talk about?',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                  )
              ),
              SizedBox(width: 16),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: _toggleChatStyles,
                icon: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    image: currentChatStyleId != null ? DecorationImage(
                      image: CachedNetworkImageProvider(ref.read(asyncChatStylesProvider).value!.firstWhere((style) => style.id == currentChatStyleId).icon)
                    ) : null,
                    shape: BoxShape.circle
                  ),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                )
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 5,
                  minLines: 1,
                  keyboardAppearance: Brightness.dark,
                  keyboardType: widget.keyboardType,
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFFAFAFF),
                    focusColor: Color(0xFF6D91F4),
                    hintText: widget.hintText,
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).hintColor
                    )
                  ),
                  onChanged: (text) {
                    if (widget.onInputChange != null) widget.onInputChange!(text);
                  },
                  onSubmitted: (String text) {
                    onSubmit(text: text);
                    _controller.text = '';
                  },
                  focusNode: focusNode,
                  autofocus: widget.autofocus,
                ),
              ),
              TextButton(
                  onPressed: () {
                    onSubmit(text: _controller.text);
                  },
                  child: Text(widget.actionText)
              )
            ],
          ),
          Offstage(
            offstage: !_chatStylesVisible,
            child: Container(
              height: 230,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              alignment: Alignment.topCenter,
              child: ref.watch(asyncChatStylesProvider).when(
                  data: (styles) => GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  loading: () => Center(
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
      ),
    );
  }

  void _toggleChatStyles() {
    setState(() {
      _chatStylesVisible = !_chatStylesVisible;
    });
    if (_chatStylesVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void onSubmit({String? text}) async {
    widget.onSubmit!(text);
    _controller.clear();
    focusNode.unfocus();
    ref.invalidate(currentChatStyleIdProvider);
  }

  void _refreshUI() {
    if (mounted) setState(() {});
  }
}