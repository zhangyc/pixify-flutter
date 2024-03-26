import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/core/match/widgets/loading_button.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/uuid.dart';

import '../utils/dialog/input.dart';


void main(){
  runApp(DemoApp());
}
class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoChat(),
    );
  }
}
class DemoChat extends StatefulWidget {
  const DemoChat({super.key});

  @override
  State<DemoChat> createState() => _DemoChatState();
}

class _DemoChatState extends State<DemoChat> {
  List<IMMessage> messages=[];
  TextEditingController controller=TextEditingController();
  List<MetaToken> tokens=[];
  List<MetaToken> answer=[];
  late FlutterTts flutterTts;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.6;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;
  SonaTask? task;
  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;
  @override
  void initState() {
    super.initState();
    initTts();
  }
  dynamic initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }
  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future<void> _getDefaultEngine() async {
    final e=await flutterTts.getEngines;
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future<void> _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if(targetLanguage!=null){
     bool available= await flutterTts.isLanguageAvailable(targetLanguage!.code);
     bool installed= await flutterTts.isLanguageInstalled(targetLanguage!.code);
     if(available&&installed){
       flutterTts.setLanguage(targetLanguage!.code);
       dynamic m=await getDeviceLanguageInfo();
       await flutterTts.setVoice(m);
       if (_newVoiceText != null) {
         if (_newVoiceText!.isNotEmpty) {
           await flutterTts.speak(_newVoiceText!);
         }
       }
     }else{
       Fluttertoast.showToast(msg: '您要使用该功能需要去设置页面下载对应的语言包资源,${targetLanguage!.label}');
       return;
       if (_newVoiceText != null) {
         if (_newVoiceText!.isNotEmpty) {
           await flutterTts.speak(_newVoiceText!);
         }
       }
     }
    }

  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
  Future getDeviceLanguageInfo() async{
    if(targetLanguage==null){
      throw "TargetLanguage is required";
    }
    List voices=await flutterTts.getVoices;
    return  Map<String,String>.from(voices.firstWhere((element) => element['locale']==targetLanguage!.code!));
  }
  Future<void> _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }
  Language? targetLanguage;
  List<String> correctAnswer=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text('${targetLanguage?.label}'),
          IconButton(onPressed: () async{
            var value = await _showLanguageSelectionDialog(context,);
            targetLanguage=value;


            setState(() {

            });
          }, icon: Icon(Icons.language))
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int i) {
                        IMMessage m=messages[i];
                    return Container(
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(
                          minWidth: 48,
                          minHeight: 48,
                          maxWidth: MediaQuery.of(context).size.width*0.8
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: FlutterLogo(),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(m.content)
                        ],
                      ),
                    );
                  },
                  childCount: messages.length, // 指定列表项数量
                ),
              ),

            ],
          ),

          Positioned(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Wrap(
                    children: tokens.map((e) => GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 2
                            ),
                          color: e.selectState?Colors.blue:Colors.white
                        ),
                        padding: EdgeInsets.all(4),
                        child: Text(e.text),
                      ),
                      onTap: (){
                        _newVoiceText=e.text;
                        _speak();
                        e.selectState=!e.selectState;
                        if(e.selectState){
                          answer.add(e);

                        }else {
                          answer.removeWhere((element) => element==e);
                        }
                        setState(() {

                        });
                      },
                    )
                    ).toList(),
                    runSpacing: 8,
                    spacing: 8,
                  ),
                  Divider(height: 2,color: Colors.black,),
                  Wrap(
                    children: answer.map((e) => e.selectState?Text(e.text):Container()
                    ).toList(),
                    runSpacing: 8,
                    spacing: 8,
                  ),
                  TextButton(onPressed: (){
                    List<String> userAnswers=answer.map((e) => e.text).toList();
                    if(userAnswers.join()==correctAnswer.join()){
                      _newVoiceText='恭喜你，你答对了';
                      messages.add(IMMessage.textMessage(messageId: uuid.v1(), senderId: uuid.v1(), receiverId: uuid.v1(), text: task!.sentence??''));
                      setState(() {

                      });
                      _speak();
                      Fluttertoast.showToast(msg: '恭喜你，你答对了');
                    }else {
                      _newVoiceText='看起来有点问题';
                      _speak();
                      Fluttertoast.showToast(msg: '看起来有点问题');
                    }

                  }, child: Text('Next')),
                  TextField(
                    controller: controller,

                    decoration: InputDecoration(
                      suffixIcon: LoadingButton(onPressed: () async{
                        if(controller.text.isEmpty){
                          return;
                        }
                        if(targetLanguage==null){
                          Fluttertoast.showToast(msg: '必须选择一个目标语言');
                          return;
                        }
                        try{
                          Response result=await post('/word/split',data: {
                            "txt":controller.text,
                            "language":targetLanguage?.code, // 目标语言
                          });
                          if(result.statusCode==200&&result.data['code']=="0"){
                            task=SonaTask.fromJson(result.data['data']);
                            if(task!.word!.isEmpty){
                              return;
                            }
                            correctAnswer=List.from(task!.word!);
                            print('正确答案${correctAnswer}');
                            List<String> s=task!.word??[]..shuffle(Random(DateTime.now().millisecondsSinceEpoch));
                            print('选项${s}');
                            print('正确答案2${correctAnswer}');

                            tokens=s.map((e) => MetaToken(e, false)).toList();
                            answer.clear();
                            setState(() {

                            });
                          }
                        }catch(e){
                          print(e.toString());
                        }



                      },placeholder: CircularProgressIndicator(),
                      child: Icon(Icons.arrow_circle_right,size: 40,),)
                    ),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,height: 56*5,),
            bottom: 0,)
        ],
      ),
    );
  }
}

enum MessageType {
  text,
  image,
  file,
}

class IMMessage {
  final String messageId;
  final String senderId;
  final String receiverId;
  final MessageType type;
  final dynamic content; // 消息内容，根据不同类型可能是文本、图片、文件等
  final DateTime timestamp;

  IMMessage({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.content,
    required this.timestamp,
  });

  factory IMMessage.textMessage({
    required String messageId,
    required String senderId,
    required String receiverId,
    required String text,
  }) {
    return IMMessage(
      messageId: messageId,
      senderId: senderId,
      receiverId: receiverId,
      type: MessageType.text,
      content: text,
      timestamp: DateTime.now(),
    );
  }

  factory IMMessage.imageMessage({
    required String messageId,
    required String senderId,
    required String receiverId,
    required String imageUrl,
  }) {
    return IMMessage(
      messageId: messageId,
      senderId: senderId,
      receiverId: receiverId,
      type: MessageType.image,
      content: imageUrl,
      timestamp: DateTime.now(),
    );
  }

  factory IMMessage.fileMessage({
    required String messageId,
    required String senderId,
    required String receiverId,
    required String fileUrl,
  }) {
    return IMMessage(
      messageId: messageId,
      senderId: senderId,
      receiverId: receiverId,
      type: MessageType.file,
      content: fileUrl,
      timestamp: DateTime.now(),
    );
  }
}
class MetaToken{
  String text;
  bool selectState;
  MetaToken(this.text,this.selectState);
}
class SonaTask {
  String? sentence;
  List<String>? word;

  SonaTask({this.sentence, this.word});

  SonaTask.fromJson(Map<String, dynamic> json) {
    sentence = json['sentence'];
    word = json['word'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sentence'] = this.sentence;
    data['word'] = this.word;
    return data;
  }
}
Dio _dio=Dio(options);
BaseOptions options=BaseOptions(connectTimeout: const Duration(milliseconds: 15000),
    receiveTimeout: const Duration(milliseconds: 15000),
    sendTimeout: const Duration(milliseconds: 15000),
    baseUrl: 'http://test.sona.ninja/api',
    headers: {
      'device': Platform.operatingSystem,
      'version': 'v1.0.0',
      'token': 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyODkiLCJpYXQiOjE3MTA3NDMxNDEsImV4cCI6MTAzNTA3NDMxNDF9.FqLGBtRkXgvxUyeaHZ4J31jOYgEM2ISxCB7Gb5ZNmbc',
      'locale': 'zh-CN'
    });
Future<Response> post(String path,{required dynamic data}) async{
 return await _dio.post(path,data: data);
}
enum TtsState { playing, stopped, paused, continued }
Future<Language?> _showLanguageSelectionDialog(BuildContext context) {
 return showDialog<Language?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Your Language'),
        content: SingleChildScrollView(
          child: Column(
            children: languages.map((language) {
              return LanguageButton(language: language);
            }).toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
class LanguageButton extends StatelessWidget {
  final Language language;

  const LanguageButton({Key? key, required this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle language selection here
          print('Selected language: ${language.code}');
          Navigator.of(context).pop(language); // Close the dialog after selection
        },
        child: Text(language.label),
      ),
    );
  }
}
final List<Language> languages = [
  Language(code: 'en-US', label: 'English (US)'),
  Language(code: 'en-GB', label: 'English (UK)'),
  Language(code: 'ja-JP', label: 'Japanese'),
  Language(code: 'zh-CN', label: 'Simplified Chinese'),
  Language(code: 'zh-TW', label: 'Chinese Traditional'),
  Language(code: 'ko-KR', label: 'Korean'),
  Language(code: 'th-TH', label: 'Thai'),
  Language(code: 'pt-PT', label: 'Portuguese'),
  Language(code: 'pt-BR', label: 'Portuguese (Brasil)'),
  Language(code: 'es-ES', label: 'Spanish'),
  Language(code: 'de-DE', label: 'German'),
  Language(code: 'ru-RU', label: 'Russian'),
  Language(code: 'fr-FR', label: 'French'),
  Language(code: 'yue', label: 'Cantonese'),
  Language(code: 'it-IT', label: 'Italian'),
  // Add more languages here as needed
];
class Language {
  final String code;
  final String label;

  Language({required this.code, required this.label});
}