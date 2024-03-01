import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gal/gal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_editor/image_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';

import '../../../account/providers/profile.dart';
import '../../../common/services/common.dart';
import '../../../utils/image/image_merge.dart';
import '../../widgets/generate_banner.dart';
import '../providers/duo_provider.dart';

class DuosnapButton extends ConsumerStatefulWidget {
  const DuosnapButton(this.target, this.model, {super.key});
  final MatchUserInfo target;
  final SdModel model;
  @override
  ConsumerState createState() => _DuosnapButtonState();
}

class _DuosnapButtonState extends ConsumerState<DuosnapButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{

        if(mounted){
          Navigator.pop(context);
        }
        startGenerate.value=uuid.v1();

        FileInfo src=await DefaultCacheManager().downloadFile(ref.read(myProfileProvider)!.avatar??'');
        FileInfo dst=await DefaultCacheManager().downloadFile(widget.target.avatar!);
        final option = ImageMergeOption(
          canvasSize: Size(600*2, 800),
          format: OutputFormat.png(),
        );
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
        final result = await ImageMerger.mergeToMemory(option: option);
        final s =await uploadFile(bytes: result!);
        final response=await post('/merge-photo/create',data: {
           // 原图URL
          "photoUrl":s,
          // 对方用户ID
          "targetUserId":widget.target.id,
          // 模型 - 测试是任意写
          "modelId":widget.model.id
        });
        if(response.isSuccess){

        }
      },
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: 16
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.black), // 底部边框样式
                top: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                left: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                right: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
              ),
            ),
            child: Text(widget.model.name??'',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
