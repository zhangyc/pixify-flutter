import 'package:flutter/material.dart';

class VoiceMessageRecorder extends StatefulWidget {
  const VoiceMessageRecorder({super.key});

  @override
  State<StatefulWidget> createState() => _VoiceMessageRecorderState();
}

class _VoiceMessageRecorderState extends State<VoiceMessageRecorder> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.33),
      child: Center(
        child: FittedBox(
          child: Container(
            width: 160,
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
    );
  }
}