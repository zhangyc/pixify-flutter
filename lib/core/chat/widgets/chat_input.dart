import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController? controller;
  final double? height;
  final String? initialText;
  final String hintText;
  final TextInputType keyboardType;
  final String actionText;
  final Function(String)? onInputChange;
  final void Function({String? text})? onSubmit;
  final int maxLength;
  final FocusNode? focusNode;
  final bool autofocus;

  const ChatInput({
    Key? key,
    this.controller,
    this.height,
    this.initialText,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.actionText = 'Send',
    this.onInputChange,
    this.onSubmit,
    this.maxLength = 1024,
    this.focusNode,
    this.autofocus = false
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> with AutomaticKeepAliveClientMixin {
  late final TextEditingController _controller;
  late FocusNode focusNode;
  late double height;

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
    super.build(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
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
                  hintText: widget.hintText
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
    );
  }

  void onSubmit({String? text}) async {
    widget.onSubmit!(text: text);
    _controller.clear();
    focusNode.unfocus();
  }

  void _refreshUI() {
    if (mounted) setState(() {});
  }
}