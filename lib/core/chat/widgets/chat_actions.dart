import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/text/gradient_colored_text.dart';
import 'package:sona/core/chat/providers/chat_action.dart';
import 'package:sona/core/chat/screens/function.dart';

class ChatActions extends ConsumerStatefulWidget {
  const ChatActions({super.key, required this.onAct});
  final void Function(ChatActionMode) onAct;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatActionsState();
}

class _ChatActionsState extends ConsumerState<ChatActions> {
  final double _size = 36;
  final _stopwatch = Stopwatch();
  late Offset _joystickCenter = Offset.zero;
  late Offset _manualCenter;
  late Offset _hookCenter;
  late Offset _suggestionCenter;
  late OverlayEntry _manualEntry;
  late OverlayEntry _hookEntry;
  late OverlayEntry _suggestionEntry;
  late OverlayEntry _joystickEntry;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final renderBox = context.findRenderObject() as RenderBox;
      _joystickCenter = renderBox.localToGlobal(Offset(_size * 0.5, _size * 0.5));
      ref.read(joystickCenterPositionProvider.notifier).state = _joystickCenter;
      _createEntry();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(joystickCenterPositionProvider);
    double opacity;
    if (position == Offset.zero || _joystickCenter == Offset.zero) {
      opacity = 1;
    } else if (position == _joystickCenter) {
      opacity = 1;
    } else {
      opacity = 0;
    }
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: _size,
          height: _size,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFCB5CFF),
                Color(0xFF44FFFF)
              ]
            ),
            shape: BoxShape.circle
          ),
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          child: ref.watch(sonaLoadingProvider) ? const CircularProgressIndicator(strokeWidth: 2) : const GradientColoredText(
              text: 'S',
              style: TextStyle(fontSize: 14)
          )
        ),
      ),
    );
  }

  void _createEntry() {
    _manualCenter = Offset(_joystickCenter.dx - MediaQuery.of(context).size.width * 0.25, _joystickCenter.dy);
    _hookCenter = Offset(_joystickCenter.dx + MediaQuery.of(context).size.width * 0.25, _joystickCenter.dy);
    _suggestionCenter = Offset(_joystickCenter.dx, _joystickCenter.dy - _size * 2);

    _manualEntry = OverlayEntry(
        builder: (context) => ProviderScope(
            parent: ProviderScope.containerOf(context),
            child: ChatActionButton(
                action: ChatActionMode.manual,
                position: _manualCenter,
                size: _size
            )
        )
    );
    _hookEntry = OverlayEntry(
        builder: (context) => ProviderScope(
            parent: ProviderScope.containerOf(context),
            child: ChatActionButton(
                action: ChatActionMode.hook,
                position: _hookCenter,
                size: _size
            )
        )
    );
    _suggestionEntry = OverlayEntry(
        builder: (context) => ProviderScope(
            parent: ProviderScope.containerOf(context),
            child: ChatActionButton(
                action: ChatActionMode.suggestion,
                position: _suggestionCenter,
                size: _size
            )
        )
    );
    _joystickEntry = OverlayEntry(
        builder: (_) => ProviderScope(
          parent: ProviderScope.containerOf(context),
          child: JoystickOverlayEntry(size: _size)
        )
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    Overlay.of(context).insertAll([_manualEntry, _hookEntry, _suggestionEntry, _joystickEntry]);
    _stopwatch.reset();
    _stopwatch.start();
  }

  void _onPointerMove(PointerMoveEvent event) {
    ref.read(joystickCenterPositionProvider.notifier).state = event.position;
    final action = ref.read(joystickHitProvider);
    if ((event.position - _manualCenter).distance < _size * 1.2) {
      if (action != ChatActionMode.manual) {
        ref.read(joystickHitProvider.notifier).state = ChatActionMode.manual;
        HapticFeedback.selectionClick();
      }
    } else if ((event.position - _hookCenter).distance < _size * 1.2) {
      if (action != ChatActionMode.hook) {
        ref.read(joystickHitProvider.notifier).state = ChatActionMode.hook;
        HapticFeedback.selectionClick();
      }
    } else if ((event.position - _suggestionCenter).distance < _size * 1.2) {
      if (action != ChatActionMode.suggestion) {
        ref.read(joystickHitProvider.notifier).state = ChatActionMode.suggestion;
        HapticFeedback.selectionClick();
      }
    } else {
      ref.read(joystickHitProvider.notifier).state = ChatActionMode.docker;
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    ref.read(joystickCenterPositionProvider.notifier).state = _joystickCenter;
    _manualEntry.remove();
    _hookEntry.remove();
    _suggestionEntry.remove();
    _joystickEntry.remove();
    _stopwatch.stop();

    var mode = ref.read(joystickHitProvider);
    if ((event.position - _joystickCenter).distance < _size && _stopwatch.elapsedMicroseconds >= 2000) {
      mode = ChatActionMode.sona;
    }
    _stopwatch.reset();
    widget.onAct(mode);
  }
}

class JoystickOverlayEntry extends ConsumerWidget {
  const JoystickOverlayEntry({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(joystickCenterPositionProvider);
    return Positioned(
      top: position.dy - size * 0.5,
      left: position.dx - size * 0.5,
      child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFCB5CFF),
                    Color(0xFF44FFFF)
                  ]
              ),
              shape: BoxShape.circle
          ),
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          child: const GradientColoredText(
              text: 'S',
              style: TextStyle(fontSize: 14)
          )
      ),
    );
  }
}

class ChatActionButton extends ConsumerWidget {
  const ChatActionButton({
    super.key,
    required this.action,
    required this.position,
    required this.size
  });
  final ChatActionMode action;
  final Offset position;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hit = ref.watch(joystickHitProvider);
    final scale = hit == action ? 2 : 1.6;
    return Positioned(
      top: position.dy - size * scale * 0.5,
      left: position.dx - size * scale * 0.5,
      child: Container(
          width: size * scale,
          height: size * scale,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFCB5CFF),
                    Color(0xFF44FFFF)
                  ]
              ),
              shape: BoxShape.circle
          ),
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          child: GradientColoredText(
              text: action.name,
              style: TextStyle(fontSize: 14)
          )
      ),
    );
  }
}