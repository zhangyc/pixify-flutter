import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/text_message.dart';
import 'package:sona/utils/global/global.dart';

import '../../../../common/models/user.dart';
import 'mode_provider.dart';

class ChatInstructionInput extends ConsumerStatefulWidget {
  const ChatInstructionInput(
      {Key? key,
      required this.chatId,
      required this.otherInfo,
      required this.onSendMessage})
      : super(key: key);

  final int chatId;
  final UserInfo otherInfo;
  final Future Function(Map<String, dynamic>) onSendMessage;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ChatInstructionInputState();
}

class ChatInstructionInputState extends ConsumerState<ChatInstructionInput>
    with RouteAware, SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  // OverlayEntry? _voiceEntry;
  final _stopwatch = Stopwatch();
  Timer? _timer;
  bool detecting = false;

  static const enterTimesKey = 'enter_times';

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
    // 简化输入处理，不需要翻译模式
    ref
        .read(manualInputProvider(widget.chatId).notifier)
        .update((state) => _controller.text);

    // 触发UI更新以显示/隐藏发送按钮
    setState(() {});
  }

  void _focusListener() {
    if (_focusNode.hasFocus) {
      ref
          .read(keyboardExtensionVisibilityProvider.notifier)
          .update((state) => true);
      Future.delayed(
          const Duration(milliseconds: 500),
          () => ref.read(softKeyboardHeightProvider.notifier).update(
              (state) => max(state, MediaQuery.of(context).viewInsets.bottom)));
      Future.delayed(
          const Duration(milliseconds: 1000),
          () => ref.read(softKeyboardHeightProvider.notifier).update(
              (state) => max(state, MediaQuery.of(context).viewInsets.bottom)));
      Future.delayed(
          const Duration(milliseconds: 3000),
          () => ref.read(softKeyboardHeightProvider.notifier).update(
              (state) => max(state, MediaQuery.of(context).viewInsets.bottom)));
    } else {
      Future.delayed(
          const Duration(milliseconds: 500),
          () => ref.read(paddingBottomHeightProvider.notifier).update(
              (state) => max(state, MediaQuery.of(context).padding.bottom)));
    }
  }

  // 语音相关状态变量已移除

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 输入框
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                    child: _buildTextInput(),
                  ),
                ),

                const SizedBox(width: 12),

                // 发送按钮
                if (_controller.text.trim().isNotEmpty)
                  GestureDetector(
                    onTap: _sendTextMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.send,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 发送文本消息
  void _sendTextMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    widget.onSendMessage(TextMessage.buildContent(text, false));
    _controller.clear();

    SonaAnalytics.log('text_message_sent', {
      'chat_id': widget.chatId,
      'user_id': widget.otherInfo.id,
      'message_length': text.length,
    });
  }

  // 构建文本输入框
  Widget _buildTextInput() {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        maxLines: 5,
        minLines: 1,
        maxLength: 160,
        buildCounter: (BuildContext _,
                {required int currentLength,
                required bool isFocused,
                required int? maxLength}) =>
            null,
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
        autocorrect: true,
        cursorWidth: 1.8,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          isDense: true,
          filled: true,
          fillColor: Theme.of(context).cardColor,
          hintText: 'Type a message...',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w400,
              ),
        ),
        onSubmitted: (String text) {
          _sendTextMessage();
        },
        autofocus: false,
      ),
    );
  }
}

class RecordDurationWidget extends StatefulWidget {
  const RecordDurationWidget({
    super.key,
    required this.stopwatch,
  });
  final Stopwatch stopwatch;

  @override
  State<StatefulWidget> createState() => _RecordDurationState();
}

class _RecordDurationState extends State<RecordDurationWidget> {
  late Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = widget.stopwatch.elapsed.inSeconds;
    if (elapsed < 1) {
      return Text('  ');
    }
    return Text(
      '${widget.stopwatch.elapsed.inSeconds.toString()}s',
      style:
          Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

final recordButtonLongPressedProvider = StateProvider<bool>((ref) {
  ref.listenSelf((previous, next) {
    if (!next) {
      ref.read(recordButtonDeltaProvider.notifier).update(0);
    }
  });
  return false;
});

final keyboardExtensionVisibilityProvider = StateProvider<bool>((ref) => false);

class RecordButtonDeltaHorizontalNotifier extends StateNotifier<double> {
  RecordButtonDeltaHorizontalNotifier(super.state);

  void update(double value) {
    state = value;
  }

  void reset() {
    state = 0;
  }
}

final recordButtonDeltaProvider =
    StateNotifierProvider<RecordButtonDeltaHorizontalNotifier, double>(
        (ref) => RecordButtonDeltaHorizontalNotifier(0));
