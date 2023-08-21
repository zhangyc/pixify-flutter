import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sona/core/chat/screens/function.dart';

import '../../../common/widgets/text/gradient_colored_text.dart';

class ChatDirectiveButton extends StatefulWidget {
  const ChatDirectiveButton({
    super.key,
    required this.onAction,
  });
  final FutureOr Function(ChatActionMode) onAction;

  @override
  State<StatefulWidget> createState() => _ChatDirectiveButtonState();
}

class _ChatDirectiveButtonState
    extends State<ChatDirectiveButton>
    with SingleTickerProviderStateMixin {

  final _size = 72;
  late final Offset _center = Offset(_size/2, _size/2);
  var _pointerDown = false;
  double get size => _pointerDown ? 78 : 72;
  List<BoxShadow> get boxShadow => _pointerDown ? [
    BoxShadow(
      color: Theme.of(context).colorScheme.primaryContainer,
      blurRadius: 3
    )
  ] : [];

  final _eventPosition = ValueNotifier<Offset>(Offset.zero);
  ChatActionMode _active = ChatActionMode.docker;
  var _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            left: 100,
            bottom: 18,
            child: Visibility(
              visible: _pointerDown,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _active == ChatActionMode.manuel ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
                  border: Border.all(color: Theme.of(context).colorScheme.primaryContainer),
                  shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                child: GradientColoredText(text: '手动', style: TextStyle(fontSize: 14))
              )
            )
          ),
          Positioned(
            right: 100,
            bottom: 18,
            child: Visibility(
              visible: _pointerDown,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _active == ChatActionMode.sona ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
                  border: Border.all(color: Theme.of(context).colorScheme.primaryContainer),
                  shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                child: GradientColoredText(text: 'Sona', style: TextStyle(fontSize: 14))
              )
            )
          ),
          Positioned(
              top: 0,
              child: Visibility(
                visible: _pointerDown,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: _active == ChatActionMode.suggestion ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
                      border: Border.all(color: Theme.of(context).colorScheme.primaryContainer),
                      shape: BoxShape.circle
                  ),
                  alignment: Alignment.center,
                  child: GradientColoredText(text: '建议', style: TextStyle(fontSize: 14))
                )
              )
          ),
          Positioned(
            bottom: 0,
            width: 78,
            child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: _onPointerDown,
                onPointerMove: _onPointerMove,
                onPointerUp: _onPointerUp,
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 200),
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      color: _pointerDown ? Colors.white : null,
                      gradient: _pointerDown ? null : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primaryContainer,
                            Theme.of(context).colorScheme.secondaryContainer,
                          ]
                      ),
                      shape: BoxShape.circle,
                      boxShadow: boxShadow
                  ),
                  alignment: Alignment.center,
                  child: _pointerDown ? JoyStick(position: _eventPosition, size: size) : _loading ? CircularProgressIndicator() : GradientColoredText(text: 'S', style: TextStyle(fontSize: 28)),
                )
            ),
          )
        ],
      ),
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _pointerDown = true;
    });
    _eventPosition.value = event.localPosition;
  }

  FutureOr _onPointerUp(_) async {
    final active = _active;
    setState(() {
      _active = ChatActionMode.docker;
      _loading = true;
      _pointerDown = false;
    });
    try {
      await widget.onAction(active);
    } catch(e) {
      //
      debugPrint(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }

    _eventPosition.value = Offset.zero;
  }

  void _onPointerMove(PointerMoveEvent event) {
    _eventPosition.value = event.localPosition;
    final offsetFromCenter = event.localPosition - _center;
    final distance = offsetFromCenter.distance;
    final direction = offsetFromCenter.direction;
    var manualDirection = (Offset(0,39) - _center).direction;
    var sonaDirection = (Offset(78, 39) - _center).direction;
    var suggestionDirection = (Offset(39, 0) - _center).direction;
    var cancelDirection = (Offset(39, 78) - _center).direction;

    if (distance > 36) {
      if ((direction - manualDirection).abs() < pi * 0.1) {
        if (_active != ChatActionMode.manuel) {
          setState(() {
            _active = ChatActionMode.manuel;
          });
          HapticFeedback.selectionClick();
        }
      }
      if ((direction - sonaDirection).abs() < pi * 0.1) {
        if (_active != ChatActionMode.sona) {
          setState(() {
            _active = ChatActionMode.sona;
          });
          HapticFeedback.selectionClick();
        }
      }
      if ((direction - suggestionDirection).abs() < pi * 0.1) {
        if (_active != ChatActionMode.suggestion) {
          setState(() {
            _active = ChatActionMode.suggestion;
          });
          HapticFeedback.selectionClick();
        }
      }
      if ((direction - cancelDirection).abs() < pi * 0.1) {
        if (_active != ChatActionMode.docker) {
          setState(() {
            _active = ChatActionMode.docker;
          });
        }
      }
    } else {
      if (_active != ChatActionMode.chat) {
        setState(() {
          _active = ChatActionMode.chat;
        });
      }
    }
  }
}

class JoyStick extends StatefulWidget {
  const JoyStick({super.key, required this.size, required this.position});
  final double size;
  final ValueNotifier<Offset> position;

  @override
  State<StatefulWidget> createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {

  late final containerSize = widget.size;
  late final stickSize = widget.size / 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.position,
      builder: (_, __) {
        var position = widget.position.value;
        final center = Offset(widget.size / 2, widget.size / 2);
        final delta = position - center;
        final distance = delta.distance;
        final direction = delta.direction;
        if (distance > widget.size/2) {
          // 角度跟随，stick圆心不超出半径
          // 第一次position，计算到stick圆心的坐标
          position = Offset.fromDirection(direction, widget.size/2) + center;
          // 第二次position，转换到stick左上角的坐标
          position = position - Offset(stickSize/2, stickSize/2);
        } else {
          // event的坐标是stick的圆心坐标，需要转换到stick左上角
          position = position - Offset(stickSize/2, stickSize/2);
        }
        return Container(
          width: containerSize,
          height: containerSize,
          decoration: const BoxDecoration(
              shape: BoxShape.circle
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: position.dy,
                  left: position.dx,
                  child: Container(
                    width: stickSize,
                    height: stickSize,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        shape: BoxShape.circle
                    ),
                  )
              )
            ],
          ),
        );
      }
    );
  }
}