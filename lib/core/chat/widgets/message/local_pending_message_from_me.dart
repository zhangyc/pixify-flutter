import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/message.dart';

class LocalPendingMessageFromMe extends ConsumerStatefulWidget {
  const LocalPendingMessageFromMe({
    super.key,
    required this.message,
    required this.myLocale,
    required this.onSucceed
  });
  final ImMessage message;
  final Locale? myLocale;
  final Function() onSucceed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocalPendingMessageFromMeState();
}

class _LocalPendingMessageFromMeState extends ConsumerState<LocalPendingMessageFromMe> {

  @override
  void initState() {
    widget.message.pending!.catchError((e) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (widget.message.origin != null && widget.message.origin!.isNotEmpty) Container(
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   decoration: BoxDecoration(
              //       color: Theme.of(context).primaryColor
              //   ),
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     widget.message.origin!,
              //     style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //         color: Colors.white,
              //         height: 1.5
              //     ),
              //   ),
              // ),
              if (widget.message.content.isNotEmpty) Text(
                widget.message.content,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    height: 1.5,
                  locale: widget.myLocale
                ),
              )
            ],
          ),
        ),
        FutureBuilder<void>(
          key: ValueKey(widget.message.pending),
          future: widget.message.pending,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return GestureDetector(
                onTap: () {
                  widget.message.pending = widget.message.func!();
                  widget.message.pending!.then((value) {
                    widget.onSucceed();
                  });
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: const Icon(
                    Icons.refresh,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: EdgeInsets.only(left: 12),
                child: const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 1.5)
                ),
              );
            }
            return Container();
          }
        )
      ],
    );
  }
}