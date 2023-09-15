import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../../utils/dialog/input.dart';

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
        Text(widget.message.content, style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white
        )),
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
                child: SizedBox(
                  height: 24,
                  width: 58,
                  child: Text('Resend', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red))
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator()
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