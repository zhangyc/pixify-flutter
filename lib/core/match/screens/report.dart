import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/providers/dio.dart';

class Report extends ConsumerStatefulWidget {
  const Report(this.type, this.userId, {super.key});
  final ReportType type;
  final int userId;
  @override
  ConsumerState createState() => _ReportState();
}

class _ReportState extends ConsumerState<Report> {
  TextEditingController _textEditingController=TextEditingController();
  RestrictedContent rc=RestrictedContent.politics;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: Column(
        children: [
          Text('RestrictedContent'),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: RestrictedContent.values.map((e) => e.code==-1?Container():GestureDetector(
              onTap: (){
                rc=e;
                setState(() {

                });
              },
              child: Container(
                  decoration:BoxDecoration(
                    color: rc==e?Colors.cyan:Colors.deepPurple,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('${e.displayName}')),
            )
            ).toList(),
          ),
          TextField(controller: _textEditingController,decoration: InputDecoration(
            hintText: 'Please enter the reason for reporting'
          ),),
          ElevatedButton(onPressed: (){
            if(_textEditingController.text.isEmpty){
              return;
            }
            ref.read(dioProvider).post('/report/create',data: {
              "sourceType":widget.type==ReportType.user?1:2, // 举报类型，见枚举，目前固定 1，举报用户
              "sourceId":widget.userId, // 被举报的用户ID
              "reasonId":rc.code, // 举报原因：见枚举
              "content":_textEditingController.text // 举报内容，可以为空
            });
          }, child: Text('submit'))
        ],
      ),
    );
  }
}
enum ReportType{
  user,
  message;
}
enum RestrictedContent {
  politics(1,'politics'),
  gore(2,'gore'),
  pornography(3,'pornography'),
  scam(4,'scam'),
  personalAttack(5,'personalAttack'),
  other(6,'other'),
  undefined(-1,'');

  const RestrictedContent(this.code, this.displayName);
  final int code;
  final String displayName;
  factory RestrictedContent.getByCode(int code){
    return RestrictedContent.values.firstWhere((value) => value.code == code,
        orElse: () => RestrictedContent.undefined);
  }
}