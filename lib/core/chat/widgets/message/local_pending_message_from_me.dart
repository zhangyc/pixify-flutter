import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/message.dart';

class LocalPendingMessageFromMe extends ConsumerStatefulWidget {
  const LocalPendingMessageFromMe({super.key, required this.message, required this.onSucceed});
  final ImMessage message;
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
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.82 - 20 - 16 * 2 - 20
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24)
          ),
          foregroundDecoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(24)
          ),
          clipBehavior: Clip.antiAlias,
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
              if (widget.message.content.isNotEmpty) Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    color: Color(0xFF454545)
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.message.content,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      height: 1.5
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 20),
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
                child: const Icon(
                  Icons.refresh,
                  size: 20,
                  color: Colors.white,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 1.5)
              );
            }
            return Container();
          }
        )
      ],
    );
  }
}