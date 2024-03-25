import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sona/core/match/widgets/loading_button.dart';


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

  SonaTask? task;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SizedBox(
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
                  TextField(
                    controller: controller,

                    decoration: InputDecoration(
                      suffixIcon: LoadingButton(onPressed: () async{
                        if(controller.text.isEmpty){
                          return;
                        }
                        try{
                          Response result=await post('/word/split',data: {
                            "txt":controller.text
                          });
                          if(result.statusCode==200&&result.data['code']=="0"){
                            task=SonaTask.fromJson(result.data['data']);
                            if(task!.word!.isEmpty){
                              return;
                            }
                            tokens=task!.word!.map((e) => MetaToken(e, false)).toList();
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
      'locale': 'en'
    });
Future<Response> post(String path,{required dynamic data}) async{
 return await _dio.post(path,data: data);
}