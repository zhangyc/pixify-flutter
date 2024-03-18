import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_editor/image_editor.dart';
import 'package:sona/core/ai_dress/ai_dress_event.dart';
import 'package:sona/core/ai_dress/dislogs.dart';
import 'package:sona/core/ai_dress/widgets/base_dialog_container.dart';

import '../../../common/app_config.dart';
import '../../../common/services/common.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../match/util/http_util.dart';
import '../../match/widgets/loading_button.dart';
import '../../persona/widgets/profile_banner.dart';
import '../../subscribe/subscribe_page.dart';
import '../../widgets/generate_banner.dart';
import '../bean/sd_template.dart';

class AddTwoImage extends StatefulWidget {
  const AddTwoImage({super.key,required this.template});
  final SdTemplate template;

  @override
  State<AddTwoImage> createState() => _AddTwoImageState();
}

class _AddTwoImageState extends State<AddTwoImage> {
  Uint8List? left;
  Uint8List? right;
  @override
  Widget build(BuildContext context) {
    return BaseDialogContainer(child: SizedBox(
      height: 590,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.current.addTwoSoloPhotosMessage,style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18
              ),),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(Assets.svgDislike),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF6F3F3),
              borderRadius: BorderRadius.circular(24)
            ),
            child: Column(
              children: [
                Align(child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(S.current.exampleLabel,style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16
                  ),),
                ),alignment: Alignment.centerLeft,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 98,height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(Assets.imagesHumanPortrait)),
                        border: Border.all(
                          color: Color(0xff2c2c2c)
                        ),
                        borderRadius: BorderRadius.circular(16)
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 98,height: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(Assets.imagesGirlPortrait)),
                          border: Border.all(
                              color: Color(0xff2c2c2c)
                          ),
                          borderRadius: BorderRadius.circular(16)
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(child: GestureDetector(
                child: Container(
                  width: 150,
                  height: 200,
                  clipBehavior: Clip.antiAlias,

                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(Assets.imagesAddPhoto),fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  foregroundDecoration: BoxDecoration(
                    image: left==null?null:DecorationImage(image: MemoryImage(left!),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                onTap: () async{

                   Uint8List? u=await showSelectPhoto(context, widget.template);
                   SonaAnalytics.log(AiDressEvent.Dress_duo_upphoto.name,{
                     'item_str_id':'left'
                   });
                   if(u!=null){
                     left=u;
                     setState(() {

                     });
                   }
                },
              )),
              SizedBox(
                width: 12,
              ),
              Expanded(child: GestureDetector(
                onTap: () async{
                  Uint8List? u=await showSelectPhoto(context, widget.template);
                  SonaAnalytics.log(AiDressEvent.Dress_duo_upphoto.name,{
                    'item_str_id':'right'
                  });
                  if(u!=null){
                    right=u;
                    setState(() {

                    });
                  }
                },
                child: Container(
                  width: 150,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Assets.imagesAddPhoto),fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  foregroundDecoration: BoxDecoration(
                      image: right==null?null:DecorationImage(image: MemoryImage(right!),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return LoadingButton(onPressed: ()async{
              if(left==null||right==null){
                return;
              }
              SonaAnalytics.log(AiDressEvent.Dress_duo_gen.name);

              try{
                HttpResult result=await post('/merge-photo/create-ai-dress');
                if(result.statusCode.toString()=='60010') {
                  final option = ImageMergeOption(
                    canvasSize: Size(600*2, 800),
                    format: OutputFormat.png(),
                  );
                  option.addImage(
                    MergeImageConfig(
                      image: MemoryImageSource(left!),
                      position: ImagePosition(
                        Offset(0, 0),
                        Size(600,800),
                      ),
                    ),
                  );
                  option.addImage(
                    MergeImageConfig(
                      image: MemoryImageSource(right!),
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
                    // 模型 - 测试是任意写
                    "modelId":widget.template.id,
                    "scene":GenerateType.profile_two.name
                  });
                  if(response.isSuccess){
                    Fluttertoast.showToast(msg:'done');
                    Future.delayed(Duration(milliseconds: 300),(){
                      startProfileGenerate.value=uuid.v1();
                    });
                  }else {
                    Fluttertoast.showToast(msg:S.current.issues);
                  }
                }else {
                  Fluttertoast.showToast(msg: S.current.onlyOneAtatime);
                }
              }catch(e){
                Fluttertoast.showToast(msg:S.current.issues);
              }
              Navigator.pop(context);
              freeTag=false;
            }, child: Container(
              alignment: Alignment.center,
              width: 343,
              height: 56,
              child: Text(S.current.generateButtonLabel,style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.white
              ),),
              decoration: BoxDecoration(
                  color: Color(0xff2c2c2c),
                  borderRadius: BorderRadius.circular(20)
              ),
            ), placeholder: Container(
              alignment: Alignment.center,
              width: 343,
              height: 56,
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(color: Colors.white,),
              ),
              decoration: BoxDecoration(
                  color: Color(0xff2c2c2c),
                  borderRadius: BorderRadius.circular(20)
              ),
            ));
          },)

        ],
      ),
    ));
  }
}
