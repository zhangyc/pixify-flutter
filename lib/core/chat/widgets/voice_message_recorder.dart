import 'package:flutter/material.dart';

class VoiceMessageRecorder extends StatefulWidget {
  const VoiceMessageRecorder({super.key, this.onCancel});
  final void Function()? onCancel;

  @override
  State<StatefulWidget> createState() => _VoiceMessageRecorderState();
}

class _VoiceMessageRecorderState extends State<VoiceMessageRecorder> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.onCancel != null) {
          widget.onCancel!();
        }
      },
      child: Material(
        color: Colors.black.withOpacity(0.33),
        child: Center(
          child: FittedBox(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Recording...', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}