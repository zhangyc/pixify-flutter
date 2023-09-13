import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../../utils/dialog/input.dart';

class LocalPendingMessageFromMe extends StatefulWidget {
  const LocalPendingMessageFromMe({super.key, required this.message});
  final ImMessage message;

  @override
  State<StatefulWidget> createState() => _LocalPendingMessageFromMeState();
}

class _LocalPendingMessageFromMeState extends State<LocalPendingMessageFromMe> {

  @override
  void initState() {
    widget.message.pending!.catchError((e) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 70, bottom: 12, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onLongPress: _onLongPress,
                  child: Container(
                    padding: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer, width: 2)
                        )
                    ),
                    alignment: Alignment.centerRight,
                    child: Text(widget.message.content, style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
              ),
              SizedBox(width: 20),
              FutureBuilder<void>(
                future: widget.message.pending,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return GestureDetector(
                      child: SizedBox(
                        height: 24,
                        width: 48,
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
          ),
        ],
      ),
    );
  }


  void _onLongPress() async {
    final action = await showRadioFieldDialog(context: context, options: {'Copy': 'copy', 'Delete': 'delete'}, dismissible: true);
    if (action == 'copy') {
      Clipboard.setData(ClipboardData(text: widget.message.content));
      Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
    } else if (action == 'delete') {
      Fluttertoast.showToast(msg: 'todo');
    }
  }
}