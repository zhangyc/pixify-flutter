import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../../common/widgets/text/gradient_colored_text.dart';
import '../../../../utils/dialog/input.dart';

class MessageFromMe extends StatefulWidget {
  const MessageFromMe({super.key, required this.message});
  final ImMessage message;

  @override
  State<StatefulWidget> createState() => _MessageFromMeState();
}

class _MessageFromMeState extends State<MessageFromMe> {
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
              Visibility(
                visible: widget.message.time.add(const Duration(hours: 2)).isAfter(DateTime.now()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(msg: '赞');
                      },
                      child: Text('👍'),
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: '孬');
                        },
                        child: Text('👎')
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
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
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.message.time.toMessageTime(),
                style: Theme.of(context).textTheme.bodySmall
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: () => null,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)
                  ),
                  alignment: Alignment.center,
                  child: Text('\u{270D}'),
                ),
              ),
              Visibility(
                visible: !widget.message.knowledgeAdded,
                child: GestureDetector(
                  onTap: () => null,
                  child: Container(
                    height: 28,
                    width: 28,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1)
                    ),
                    alignment: Alignment.center,
                    child: GradientColoredText(text: 'S', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              SizedBox(width: 12)
            ],
          )
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