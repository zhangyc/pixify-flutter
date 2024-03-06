import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/core/match/widgets/tuosnap_dialog.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../account/providers/interests.dart';
import '../../../account/providers/profile.dart';
import '../../../account/services/info.dart';
import '../../../common/permission/permission.dart';
import '../../../common/widgets/button/colored.dart';
import '../../../common/widgets/tag/hobby.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/crop_image.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../providers/update_info_provider.dart';
import '../util/event.dart';
import 'package:sona/core/match/widgets/avatar_animation.dart';
class Editbio extends StatelessWidget {
  const Editbio({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return Padding(

        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Color(0xFF2C2C2C),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            shadows: [
              BoxShadow(
                color: Color(0xFF2C2C2C),
                blurRadius: 0,
                offset: Offset(0, -4),
                spreadRadius: 0,
              )
            ],
          ),
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ref.watch(updateProfileBioProvider).when(
                  data: (data) => Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.current.bio,style: TextStyle(
                                color: Color(0xff2c2c2c),
                                fontSize: 18,
                                fontWeight: FontWeight.w900
                            ),),
                            GestureDetector(child: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
                              onTap: (){
                                Navigator.pop(context);
                              },)
                          ],
                        ),

                        SizedBox(
                          height: 16,
                        ),
                        Text(S.current.hereSonaCookedUpForU,style: TextStyle(
                            color: Color(0xff2c2c2c),
                            fontSize: 14,
                            fontWeight: FontWeight.w900
                        ),),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 248,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff2c2c2c),
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: TextField(
                            onTapOutside: (cv){
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                            ),
                            controller: controller..text=data.data??'',
                            keyboardType: TextInputType.multiline,
                            minLines: 7,
                            maxLines: 7,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(S.current.youCanEditItAnytime,style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: ColoredButton(
                                fontColor: Color(0xff2c2c2c),
                                size: ColoredButtonSize.large,
                                text: S.current.noThanks,
                                loadingWhenAsyncAction: false,
                                onTap: (){
                                  SonaAnalytics.log(MatchEvent.match_bio_cancel.name);
                                  Navigator.pop(context);
                                },
                                color: Color(0xfff6f3f3),
                                borderColor: Color(0xfff6f3f3),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: ColoredButton(
                                  borderColor:Color(0xff2c2c2c),
                                  fontColor: Color(0xffF6F3F3),
                                  color: Color(0xff2c2c2c),
                                  size: ColoredButtonSize.large,
                                  text: S.of(context).takeIt,
                                  loadingWhenAsyncAction: controller.text.isEmpty?false:true,
                                  onTap: () {

                                    if(controller.text.isEmpty){
                                      Navigator.pop(context);
                                      return;
                                    }
                                    SonaAnalytics.log(MatchEvent.match_bio_take.name);
                                    ref.read(myProfileProvider.notifier).updateFields(bio: controller.text).then((_) => Navigator.pop(context));
                                  }
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  loading: () => Container(
                    color: Colors.white54,
                    alignment: Alignment.center,
                    child: const SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator()
                    ),
                  ),
                  error: (err, stack) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => ref.read(asyncInterestsProvider.notifier).refresh(),
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: const Text(
                          'Cannot connect to server\ntap to retry',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.none
                          )
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      );
    },

    );
  }
}
