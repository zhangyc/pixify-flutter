import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/ai_dress/bean/sd_template.dart';
import 'package:sona/core/ai_dress/data/template_provider.dart';
import 'package:sona/core/ai_dress/dislogs.dart';
import 'package:sona/core/ai_dress/records_page.dart';
import 'package:sona/core/match/util/http_util.dart';

import '../../account/providers/profile.dart';
import '../../common/permission/permission.dart';
import '../../generated/l10n.dart';
import '../../utils/global/global.dart';
import '../match/util/event.dart';
import '../subscribe/model/member.dart';
import '../subscribe/subscribe_page.dart';
import 'ai_dress_event.dart';

class AiDressPage extends StatefulWidget {
  const AiDressPage({super.key});

  @override
  State<AiDressPage> createState() => _AiDressPageState();
}

class _AiDressPageState extends State<AiDressPage> {
  int currentTap=0;
  PageController pageController=PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.aiDressUpLabel),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c){
              return RecordsPage();
            }));
          }, child: Text(S.current.recordsLabel))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: Column(
          children: [
            Row(
              children: [
                ///
                GestureDetector(
                  child: currentTap==0?SelectedButton(text: S.current.soloLabel):IdleButton(text:  S.current.soloLabel),
                  onTap: (){
                    currentTap=0;
                    SonaAnalytics.log(AiDressEvent.Dress_duo_tab.name,{
                      'item_int_id':0
                    });
                    pageController.jumpToPage(0);
                    setState(() {

                    });
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  child: currentTap==1?SelectedButton(text: S.current.duoSnap):IdleButton(text: S.current.duoSnap),
                  onTap: (){
                    currentTap=1;
                    SonaAnalytics.log(AiDressEvent.Dress_duo_tab.name,{
                      'item_int_id':1
                    });
                    pageController.jumpToPage(1);
                    setState(() {

                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(child: PageView(
              controller: pageController,
              onPageChanged: (int value){
                currentTap=value;
                //_initData();

                setState(() {

                });
              },
              children: [
                Consumer(
                  builder: (context, ref, _) {
                    final asyncValue = ref.watch(dataSoleProvider);
                    return asyncValue.when(
                      data: (data) {
                        List soloTemplates=data;
                        // 当 Future 成功完成时调用该回调函数
                        return GridView.builder(
                          itemCount: soloTemplates.length, // 子项数量
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.75,
                            crossAxisCount: 2, // 每行显示的子项数量
                            mainAxisSpacing: 10.0, // 主轴方向（垂直方向）的间距
                            crossAxisSpacing: 10.0, // 交叉轴方向（水平方向）的间距
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            SdTemplate template=soloTemplates[index];
                            return GestureDetector(
                              child:template.url==null?Container():Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: CachedNetworkImageProvider(template.url!),fit: BoxFit.cover),
                                    border: Border.all(
                                        color: Color(0xff2c2c2c),
                                        width: 2
                                    ),
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                clipBehavior: Clip.antiAlias,
                              ),
                              onTap: () async{
                                if(!canDuoSnap){
                                  duosnap-=1;
                                  if(ref.read(myProfileProvider)!.memberType==MemberType.none){
                                    Navigator.push(context, MaterialPageRoute(builder:(c){
                                      return const SubscribePage(fromTag: FromTag.duo_snap,);
                                    }));
                                  }else if(ref.read(myProfileProvider)!.memberType==MemberType.club){
                                    SonaAnalytics.log(AiDressEvent.Dress_gopay.name);

                                    Navigator.push(context, MaterialPageRoute(builder:(c){
                                      return const SubscribePage(fromTag: FromTag.pay_match_arrow,);
                                    }));
                                  }else if(ref.read(myProfileProvider)!.memberType==MemberType.plus){
                                    SonaAnalytics.log(AiDressEvent.Dress_gopay.name);

                                    Fluttertoast.showToast(msg: S.current.weeklyLimitReached);
                                  }
                                  return;
                                }
                                 SonaAnalytics.log(AiDressEvent.Dress_solo_model.name);

                                 Uint8List? p=await showSelectPhoto(context,template);
                                SonaAnalytics.log(AiDressEvent.Dress_solo_upphoto.name);
                                if(p!=null){
                                   Navigator.pop(context);
                                   showYourPortrait(context, p, template);
                                 }

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
                Consumer(
                  builder: (context, ref, _) {
                    final asyncValue = ref.watch(dataDuoSnapProvider);
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
                            SdTemplate template=duoSnapTemplates[index];
                            return GestureDetector(
                              child:template.url==null?Container():Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: CachedNetworkImageProvider(template.url!),fit: BoxFit.cover),
                                    border: Border.all(
                                        color: Color(0xff2c2c2c),
                                        width: 2
                                    ),
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                clipBehavior: Clip.antiAlias,
                              ),
                              onTap: (){
                                if(!canDuoSnap){
                                  duosnap-=1;
                                  if(ref.read(myProfileProvider)!.memberType==MemberType.none){
                                    Navigator.push(context, MaterialPageRoute(builder:(c){
                                      return const SubscribePage(fromTag: FromTag.duo_snap,);
                                    }));
                                  }else if(ref.read(myProfileProvider)!.memberType==MemberType.club){
                                    SonaAnalytics.log(AiDressEvent.Dress_gopay.name);

                                    Navigator.push(context, MaterialPageRoute(builder:(c){
                                      return const SubscribePage(fromTag: FromTag.pay_match_arrow,);
                                    }));
                                  }else if(ref.read(myProfileProvider)!.memberType==MemberType.plus){
                                    SonaAnalytics.log(AiDressEvent.Dress_gopay.name);

                                    Fluttertoast.showToast(msg: S.current.weeklyLimitReached);
                                  }
                                  return;
                                }
                                SonaAnalytics.log(AiDressEvent.Dress_duo_model.name);

                                Navigator.pop(context);

                                showDuoSnapSelectPhoto(context,template);
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



              ],
            ))
          ],
        ),
      ),
    );
  }
}
class SelectedButton extends StatelessWidget {
  const SelectedButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12
      ),
      decoration: BoxDecoration(
        color: Color(0xff2c2c2c),
        borderRadius: BorderRadius.circular(14)
      ),
      child: Text(text,style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 14
      ),),
    );
  }
}
class IdleButton extends StatelessWidget {
  const IdleButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Color(0xff2c2c2c),
            width: 2
          )
      ),
      child: Text(text,style: TextStyle(
          color: Color(0xff2c2c2c),
          fontWeight: FontWeight.w900,
          fontSize: 14
      ),),
    );
  }
}