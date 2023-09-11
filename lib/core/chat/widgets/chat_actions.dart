import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/chat/providers/chat_mode.dart';

class ChatActions extends ConsumerStatefulWidget {
  const ChatActions({
    super.key,
    required this.onHookTap,
    required this.onSuggestionTap,
    required this.onSonaTap
  });
  final FutureOr Function() onSonaTap;
  final FutureOr Function() onHookTap;
  final FutureOr Function() onSuggestionTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatActionsState();
}

class _ChatActionsState extends ConsumerState<ChatActions> {

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ref.watch(sonaLoadingProvider),
      child: Opacity(
        opacity: ref.watch(sonaLoadingProvider) ? 0.3 : 1,
        child: SizedBox(
          height: 42,
          child: Row(
            children: [
              SizedBox(width: 4),
              IconButton(onPressed: _onHookTap, icon: Text('😈')),
              Expanded(
                child: ColoredButton(
                  onTap: _onSonaTap,
                  borderColor: Theme.of(context).primaryColor,
                  text: 'Sona'
                )
              ),
              IconButton(onPressed: _onSuggestionTap, icon: Text('✨')),
              SizedBox(width: 4)
            ],
          ),
        ),
      ),
    );
  }

  Future _onSonaTap() async {
    ref.read(sonaLoadingProvider.notifier).state = true;
    try {
      await widget.onSonaTap();
    } catch(e) {
      //
    } finally {
      ref.read(sonaLoadingProvider.notifier).state = false;
    }
  }

  Future _onHookTap() async {
    ref.read(sonaLoadingProvider.notifier).state = true;
    try {
      await widget.onHookTap();
    } catch(e) {
      //
    } finally {
      ref.read(sonaLoadingProvider.notifier).state = false;
    }
  }

  Future _onSuggestionTap() async {
    ref.read(sonaLoadingProvider.notifier).state = true;
    try {
      await widget.onSuggestionTap();
    } catch(e) {
      //
    } finally {
      ref.read(sonaLoadingProvider.notifier).state = false;
    }
  }
}