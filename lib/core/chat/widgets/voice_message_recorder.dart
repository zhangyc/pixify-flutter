import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceMessageRecorder extends StatefulWidget {
  const VoiceMessageRecorder({super.key});

  @override
  State<StatefulWidget> createState() => _VoiceMessageRecorderState();
}

class _VoiceMessageRecorderState extends State<VoiceMessageRecorder> {
  String? _voicePath;
  String _lastWords = '';
  bool _speechEnabled = false;

  static final _speechToText = SpeechToText();
  static final recorder = AudioRecorder();
  static final player = AudioPlayer();
  static const config = RecordConfig(
      encoder: AudioEncoder.aacLc,
      bitRate: 64000,
      sampleRate: 8000,
      numChannels: 1
  );

  @override
  void initState() {
    super.initState();
    _initSpeech();
    // _startRecording();
  }

  @override
  void dispose() {
    _stopListening();
    recorder.stop();
    super.dispose();
  }

  void _initSpeech() async {
    final available = await _speechToText.initialize(
      debugLogging: kDebugMode,
    );
    if (available) {
      _startListening();
    }
    print('stt available: $available');
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  void _stopListening() async {
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print('on speech result: ${result.recognizedWords}');
    setState(() {
      _lastWords += result.recognizedWords;
    });
  }

  void _startRecording() async {
    if (await recorder.hasPermission()) {
      recorder.start(config, path: '${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.m4a');
    }
  }

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
                Text('$_lastWords', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}