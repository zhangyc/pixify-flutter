library tiktoklikescroller;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A fullscreen vertical scroller like TikTok
///
/// Use [TikTokStyleFullPageScroller] as you would `ListView.Builder()`
class TikTokStyleFullPageScroller extends StatefulWidget {
  const TikTokStyleFullPageScroller({
    required this.contentSize,
    required this.builder,
    this.swipePositionThreshold = 0.20,
    this.swipeVelocityThreshold = 1000,
    this.animationDuration = const Duration(milliseconds: 200),
    this.controller,
  });

  /// The number of elements in the list,
  final int contentSize;

  /// A function that converts a context and an index to a Widget to be rendered
  final IndexedWidgetBuilder builder;

  /// The fraction of the screen scrolled (before lifting your finger) that will
  /// cause the card to animate to the next/previous card (otherwise the card
  /// will animate to the current card's resting position),
  final double swipePositionThreshold;

  /// This threshold will override [swipePositionThreshold] if the card is
  /// flicked a small distance but quickly,
  final double swipeVelocityThreshold;

  /// The time the card will take to animate to either off the screen or its
  /// resting position,
  final Duration animationDuration;

  /// An optional controller to request changes and to notify consumers of changes
  /// via an optional listener
  final Controller? controller;

  @override
  _TikTokStyleFullPageScrollerState createState() =>
      _TikTokStyleFullPageScrollerState();
}

class _TikTokStyleFullPageScrollerState
    extends State<TikTokStyleFullPageScroller>
    with SingleTickerProviderStateMixin {
  late Size _containerSize;
  late double _cardOffset;
  late double _dragStartPosition;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late int _cardIndex;
  late DragState _dragState;
  late Stream<int>? feedback;

  /// Internal index for tracking desired controller target page index
  int _targetIndex = -1;

  /// Event tracking between functions
  ScrollEvent? _pendingEvent;

  @override
  void initState() {
    _cardOffset = 0;
    _dragStartPosition = 0;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _cardIndex = 0;
    _dragState = DragState.idle;

    if (widget.controller != null) {
      widget.controller!.attach()?.listen((event) {
        switch (event.command) {
          case ControllerCommandTypes.jumpToPosition:
            _jumpToPosition(event.data as int);
            break;
          case ControllerCommandTypes.animateToPosition:
            _animateToPosition(event.data as int);
            break;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      /// Takes the size of the container, not the whole screen size
      _containerSize = constraints.biggest;

      return Stack(
        children: <Widget>[
          if (_cardIndex > 0)
            Positioned(
              bottom: _containerSize.height - _cardOffset,
              child: SizedBox.fromSize(
                  size: _containerSize,
                  child: widget.builder(context, _cardIndex - 1)),
            ),
          Positioned(
            top: _cardOffset,
            child: GestureDetector(
              child: SizedBox.fromSize(
                  size: _containerSize,
                  child: widget.builder(context, _cardIndex)),
              onVerticalDragStart: (DragStartDetails details) {
                setState(() {
                  _dragState = DragState.dragging;
                  _dragStartPosition = details.localPosition.dy;
                });
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _cardOffset =
                      (details.localPosition.dy - _dragStartPosition) / 1.5;
                });
              },
              onVerticalDragEnd: (DragEndDetails details) {
                bool positiveDragThresholdMet = (_cardOffset <
                        -_containerSize.height *
                            widget.swipePositionThreshold ||
                    details.primaryVelocity! < -widget.swipeVelocityThreshold);

                bool negativeDragThresholdMet = (_cardOffset >
                        _containerSize.height / widget.swipePositionThreshold ||
                    details.primaryVelocity! > widget.swipeVelocityThreshold);

                DragState _state;
                // If the length of scroll goes beyond the point of no return
                // or if a small flick was faster than the velocity threshold
                if (positiveDragThresholdMet &&
                    _cardIndex < widget.contentSize - 1) {
                  // build animation, set state to animate forward
                  // Animate to next card
                  _state = DragState.animatingForward;
                } else if (negativeDragThresholdMet) {
                  if (_cardIndex == 0) {
                    // we are trying to swipe back beyond the first card, if callback exists, call it
                    _pendingEvent = ScrollEvent(ScrollDirection.BACKWARDS,
                        ScrollSuccess.FAILED_END_OF_LIST, 0);
                    _state = DragState.animatingToCancel;
                  } else {
                    // if we are not on the first card and swiping back
                    // Animate to previous card
                    _state = DragState.animatingBackward;
                  }
                } else if (positiveDragThresholdMet &&
                    _cardIndex == widget.contentSize - 1) {
                  _pendingEvent = ScrollEvent(ScrollDirection.FORWARD,
                      ScrollSuccess.FAILED_END_OF_LIST, widget.contentSize - 1);
                  _state = DragState.animatingToCancel;
                } else {
                  // Thresholds not met so relaxing back to initial state
                  _pendingEvent = ScrollEvent(
                      _cardOffset < 0
                          ? ScrollDirection.FORWARD
                          : ScrollDirection.BACKWARDS,
                      ScrollSuccess.FAILED_THRESHOLD_NOT_REACHED,
                      null);
                  _state = DragState.animatingToCancel;
                }
                setState(() {
                  _dragState = _state;
                });
                _createAnimation();
              },
            ),
          ),
          if (_cardIndex < widget.contentSize - 1)
            Positioned(
              top: _containerSize.height + _cardOffset,
              child: SizedBox.fromSize(
                size: _containerSize,
                child: widget.builder(context, _cardIndex + 1),
              ),
            ),
        ],
      );
    });
  }

  /// Animation co-ordinating function - tracks all types of animations
  /// including releases from drag events and controller animation requests
  void _createAnimation() {
    double _end;
    switch (_dragState) {
      case DragState.animatingForward:
        _end = -_containerSize.height;
        break;
      case DragState.animatingBackward:
        _end = _containerSize.height;
        break;
      case DragState.animatingToCancel:
      default:
        _end = 0;
    }
    _animation = Tween<double>(begin: _cardOffset, end: _end)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.ease))
      ..addListener(_animationListener)
      ..addStatusListener(_animationStatusListener);
    _animationController.forward();
  }

  void _animationStatusListener(AnimationStatus _status) {
    switch (_status) {
      case AnimationStatus.completed:
        // change the card index if required,
        // change the offset back to zero,
        // change the drag state back to idle
        int _newCardIndex = _cardIndex;
        // we finished the scroll and updated the card
        switch (_dragState) {
          case DragState.animatingForward:
            _newCardIndex++;
            _pendingEvent = ScrollEvent(
                ScrollDirection.FORWARD, ScrollSuccess.SUCCESS, _newCardIndex);
            break;
          case DragState.animatingBackward:
            _newCardIndex--;
            _pendingEvent = ScrollEvent(ScrollDirection.BACKWARDS,
                ScrollSuccess.SUCCESS, _newCardIndex);
            break;
          case DragState.animatingToCancel:
            //no change to card index
            break;
          default:
        }

        if (_status != AnimationStatus.dismissed &&
            _status != AnimationStatus.forward) {
          // Animation is complete so set state accordingly
          setState(() {
            _cardIndex = _newCardIndex;
            _dragState = DragState.idle;
            _cardOffset = 0;
          });

          // Clean up all listeners including itself to ensure future
          // animations behave as they should
          _animation.removeListener(_animationListener);
          _animationController.reset();
          _animation.removeStatusListener(_animationStatusListener);

          // Send any pending events to listeners. Done here as the animation
          // has completed.
          widget.controller?.notifyListeners(_pendingEvent!);

          // check if we need to keep animated after this one is complete
          if (_targetIndex != -1 && _cardIndex != _targetIndex) {
            _animateToPosition(_targetIndex);
          } else {
            setState(() {
              _targetIndex = -1;
            });
          }
        }
        break;
      default:
    }
  }

  /// Keep track of instantaneous card position offsets
  void _animationListener() {
    setState(() {
      _cardOffset = _animation.value;
    });
  }

  /// Implementation used by [Controller] to goto the given page [targetPage]
  /// without any animation.
  void _jumpToPosition(int targetPage) {
    setState(() {
      _cardIndex = targetPage;
    });
  }

  /// Implementation used by [Controller] to goto the given page [targetPage]
  /// with an animation. This uses the existing animation settings including
  /// the duration per scroll.
  /// This function is called per page (ie multiple times if starting position
  /// and [targetPage] are not adjacent pages.
  void _animateToPosition(int targetPage) {
    // Check if further animations are required to reach [targetPage]
    if (targetPage == -1) {
      return;
    }
    if (targetPage > _cardIndex && _cardIndex != widget.contentSize - 1) {
      setState(() {
        _dragState = DragState.animatingForward;
        _targetIndex = targetPage;
      });
      _createAnimation();
    } else if (targetPage < _cardIndex && _cardIndex != 0) {
      setState(() {
        _dragState = DragState.animatingBackward;
        _targetIndex = targetPage;
      });
      _createAnimation();
    }
  }
}

/// Allows a consumer to control the list position and track current page
/// and any emitted events through a [ScrollEventCallback].
/// Track page and scroll events without further configuration. For control
/// of the Scroller, use the [attach] method.
class Controller {
  List<ScrollEventCallback> _listeners = [];
  int _page = 0;
  StreamController<ControllerFeedback>? feedback;

  /// Returns the scroll position as tracked by the controller
  int getScrollPosition() {
    return _page;
  }

  /// Command the list to switch to the given [position] in a synchronous and
  /// immediate manner. There will be no animation. To animate, use
  /// [animateToPosition] instead.
  void jumpToPosition(int position) {
    feedback?.add(ControllerFeedback(ControllerCommandTypes.jumpToPosition,
        data: position));
  }

  /// Command the list to move to the given [position] in an animated manner.
  /// To ignore animation, use [jumpToPosition] instead
  Future<void> animateToPosition(int position) async {
    feedback?.add(ControllerFeedback(ControllerCommandTypes.animateToPosition,
        data: position));
  }

  /// Called to provide a stream of [ControllerFeedback] events
  /// into the [TikTokStyleFullPageScroller] such as [jumpToPosition]
  /// and [animateToPosition] along with their associated data..
  Stream<ControllerFeedback>? attach() {
    feedback = StreamController.broadcast(onListen: () {
      if (kDebugMode) print("Something is listening to the stream of feedback events");
    }, onCancel: () {
      if (kDebugMode) print("onCancel has been called");
    });
    return feedback?.stream;
  }

  /// Allows a consumer to listen to events by registering a [ScrollEventCallback]
  /// to the controller. Remeber to use [disposeListeners] when disposing parent
  /// widgets
  void addListener(ScrollEventCallback listener) {
    _listeners.add(listener);
  }

  /// Send [ScrollEvent] notifications to all registered listeners
  void notifyListeners(ScrollEvent event) {
    if (event.pageNo != null) {
      _page = event.pageNo!;
    }
    for (var listener in _listeners) {
      listener.call(event);
    }
  }

  /// Remove all listeners to ensure there are no memory leaks.
  void disposeListeners() {
    _listeners = [];
  }
}

enum ScrollDirection { FORWARD, BACKWARDS }

/// Sent as part of a [ScrollEventCallback] to track progress of swipe events
/// [SUCCESS] is emitted for a successful swipe events, [FAILED_THRESHOLD_NOT_REACHED]
/// is emitted when a drag event doesn't meet the translation of velocity requirements
/// of a swipe event. Finally, [FAILED_END_OF_LIST] is emitted when a user tries
/// to go beyond the bounds of the array (either start or end) of the list.
enum ScrollSuccess {
  SUCCESS,
  FAILED_THRESHOLD_NOT_REACHED,
  FAILED_END_OF_LIST,
}

/// The type used to encapsulate events related to scrolling
typedef void ScrollEventCallback(ScrollEvent event);

class ControllerFeedback {
  final ControllerCommandTypes command;
  final Object? data;

  ControllerFeedback(this.command, {this.data});

  @override
  String toString() {
    return "ControllerFeedback with command: $command, and ${data.toString()}";
  }
}

class ScrollEvent {
  ScrollDirection direction;
  ScrollSuccess success;
  int? pageNo;

  ScrollEvent(this.direction, this.success, this.pageNo);

  @override
  toString() {
    return "ScrollEvent: Direction: $direction, Success: $success, Page: ${pageNo ?? "Not given"}";
  }

  @override
  bool operator ==(Object other) {
    if (other is! ScrollEvent) {
      return false;
    }
    return direction == other.direction &&
        success == other.success &&
        pageNo == other.pageNo;
  }

  @override
  int get hashCode => super.hashCode;
}

/// Enum to track the current state of manual dragging or animation
enum DragState {
  idle,
  dragging,
  animatingForward,
  animatingBackward,
  animatingToCancel,
}

/// Enum describing commands that cam sent into the controller
enum ControllerCommandTypes { jumpToPosition, animateToPosition }
