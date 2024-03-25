
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_editor/image_editor.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';

import '../../../account/providers/profile.dart';
import '../../../common/services/common.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../../utils/uuid.dart';
import '../../widgets/generate_banner.dart';
import '../providers/duo_provider.dart';
import '../util/event.dart';

class DuosnapButton extends ConsumerStatefulWidget {
  const DuosnapButton(this.target, this.model, {super.key});
  final MatchUserInfo target;
  final SdModel model;
  @override
  ConsumerState createState() => _DuosnapButtonState();
}

class _DuosnapButtonState extends ConsumerState<DuosnapButton> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        SonaAnalytics.log(DuoSnapEvent.style.name,
            {'item_str_id':widget.model.name,
             'item_int_id':widget.model.id,
            }
            );

        isLoading=true;
        setState(() {

        });
        try{
          FileInfo src=await DefaultCacheManager().downloadFile(ref.read(myProfileProvider)!.avatar??'');
          FileInfo dst=await DefaultCacheManager().downloadFile(widget.target.avatar!);
          final option = ImageMergeOption(
            canvasSize: Size(600*2, 800),
            format: OutputFormat.png(),
          );
          if(ref.read(myProfileProvider)?.gender==Gender.male){
            option.addImage(
              MergeImageConfig(
                image: MemoryImageSource(src.file.readAsBytesSync()),
                position: ImagePosition(
                  Offset(0, 0),
                  Size(600,800),
                ),
              ),
            );
            option.addImage(
              MergeImageConfig(
                image: MemoryImageSource(dst.file.readAsBytesSync()),
                position: ImagePosition(
                  Offset(600, 0),
                  Size(600,800),
                ),
              ),
            );
          }else {
            option.addImage(
              MergeImageConfig(
                image: MemoryImageSource(dst.file.readAsBytesSync()),
                position: ImagePosition(
                  Offset(0, 0),
                  Size(600,800),
                ),
              ),
            );
            option.addImage(
              MergeImageConfig(
                image: MemoryImageSource(src.file.readAsBytesSync()),
                position: ImagePosition(
                  Offset(600, 0),
                  Size(600,800),
                ),
              ),
            );
          }

          final result = await ImageMerger.mergeToMemory(option: option);
          final s =await uploadImage(bytes: result!);
          final response=await post('/merge-photo/create',data: {
            // 原图URL
            "photoUrl":s,
            // 对方用户ID
            "targetUserId":widget.target.id,
            // 模型 - 测试是任意写
            "modelId":widget.model.id,
            "scene":GenerateType.match.name
          });
          if(response.isSuccess){
            Future.delayed(Duration(milliseconds: 300),(){
              startGenerate.value=uuid.v1();
            });
          }else {
            isLoading=false;
            Fluttertoast.showToast(msg:S.current.issues);
          }
          isLoading=false;
          setState(() {

          });
          if(mounted){
            Navigator.pop(context,widget.model);
          }
        }catch(e){
          Fluttertoast.showToast(msg:S.current.issues);
          isLoading=false;
          setState(() {

          });
        }

      },
      child: Stack(
        children: [
          Container(
            width: 327,
            height: 56,
            alignment: Alignment.center,
            // padding: EdgeInsets.symmetric(
            //     vertical: 16
            // ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.black), // 底部边框样式
                top: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                left: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                right: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
              ),
            ),
            child: isLoading?SizedBox(height: 16,width: 16,child: CircularProgressIndicator(),):Text(widget.model.name??'',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
