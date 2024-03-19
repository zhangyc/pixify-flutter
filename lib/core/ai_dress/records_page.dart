import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/ai_dress/data/template_provider.dart';
import 'package:sona/core/match/bean/duosnap_task.dart';

import '../match/widgets/profile_duosnap_completed.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
          builder: (context, ref, _) {
            final asyncValue = ref.watch(recordProvider);
            return asyncValue.when(
              data: (data) {
                List duoSnapTemplates=data;
                // 当 Future 成功完成时调用该回调函数
                return GridView.builder(
                  itemCount: duoSnapTemplates.length, // 子项数量
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75,
                    crossAxisCount: 2, // 每行显示的子项数量
                    mainAxisSpacing: 10.0, // 主轴方向（垂直方向）的间距
                    crossAxisSpacing: 10.0, // 交叉轴方向（水平方向）的间距
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    DuoSnapTask template=duoSnapTemplates[index];
                    return GestureDetector(
                      child:template.targetPhotoUrl ==null?Container():Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image: CachedNetworkImageProvider(template.targetPhotoUrl!),fit: BoxFit.cover),
                            border: Border.all(
                                color: Color(0xff2c2c2c),
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(24)
                        ),
                        clipBehavior: Clip.antiAlias,
                      ),
                      onTap: (){
                        showDialog(context: context, builder: (b){
                          return ProfileDuosnapCompleted(url: template.targetPhotoUrl!,id: template.id,);
                        });
                      },
                    );
                  },
                );
              },
              loading: () {
                // 当 Future 正在加载时调用该回调函数
                return Center(child: SizedBox(child: CircularProgressIndicator(),width: 32,height: 32,));
              },
              error: (error, stackTrace) {
                // 当 Future 发生错误时调用该回调函数
                return Text('Error loading data: $error');
              },
            );
          },
        ),
      ),
    );
  }
}
