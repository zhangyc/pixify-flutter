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

import 'dm_dialog_content.dart';
import 'edit_bio.dart';
import 'match_content.dart';
import 'upload_portrait.dart';
showEditBio<T>(BuildContext context){
  showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    // elevation: 0,
    // clipBehavior: Clip.none,
    // isDismissible: true,
    builder: (BuildContext context) {

      TextEditingController controller=TextEditingController();
      return Editbio(controller: controller);
    },
  );
}

showChooseHobbies<T>(BuildContext context){
  showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    clipBehavior: Clip.none,
    isDismissible: true,
    builder: (BuildContext context) {
      const maxCount = 10;
      late Set<String> _selected={};
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9
                ),
                padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
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
                clipBehavior: Clip.antiAlias,
                child: Scaffold(
                  body: ref.watch(asyncInterestsProvider).when(
                      data: (data) => SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                        text: '${S.current.interests} ${_selected.length}',
                                        style: Theme.of(context).textTheme.titleMedium,
                                        children: [
                                          TextSpan(
                                              text: '/$maxCount',
                                              style: Theme.of(context).textTheme.bodySmall
                                          )
                                        ]
                                    ),
                                  ),
                                  GestureDetector(child: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
                                    onTap: (){
                                      Navigator.pop(context);
                                    },)
                                ],
                              ),

                              SizedBox(
                                height: 16,
                              ),

                              Text.rich(
                                TextSpan(
                                    text: '${S.current.sonaWillGenerateABioBasedOnInterests}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                    // children: [
                                    //   TextSpan(
                                    //       text: ' ${S.current.sonaWillGenerateABioBasedOnInterests}',
                                    //       style: Theme.of(context).textTheme.bodySmall
                                    //   )
                                    // ]
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: [
                                  for (final hobby in data)
                                    HobbyTag<String>(
                                        displayName: hobby.displayName,
                                        value: hobby.code,
                                        selected: _selected.contains(hobby.code),
                                        onSelect: (hb) {
                                          if (_selected.contains(hb)) {
                                            _selected.remove(hb);
                                          } else {
                                            if (_selected.length >= 10) {
                                              return;
                                            }
                                            _selected.add(hb);
                                          }
                                          setState(() {});
                                        }
                                    )
                                ],
                              ),
                            ],
                          ),
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
                  floatingActionButton: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ColoredButton(
                            fontColor: Color(0xff2c2c2c),
                            size: ColoredButtonSize.large,
                            text: S.current.buttonCancel,
                            loadingWhenAsyncAction: false,
                            onTap: (){
                             SonaAnalytics.log(MatchEvent.match_interests_cancel.name);
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
                            borderColor:_selected.isEmpty?Color(0xff7e7e7e):Color(0xff2c2c2c),
                            fontColor: Color(0xffF6F3F3),
                            color: _selected.isEmpty?Color(0xff7e7e7e):Color(0xff2c2c2c),
                            size: ColoredButtonSize.large,
                            text: S.of(context).buttonGenerate,
                            loadingWhenAsyncAction: true,
                            onTap: (){
                              SonaAnalytics.log(MatchEvent.match_bio_pop.name);

                              ref.read(myProfileProvider.notifier).updateFields(interests: _selected).then((_){
                                SonaAnalytics.log(MatchEvent.match_bio_gen.name);
                                Navigator.pop(context);
                                showEditBio(context);
                              });
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                ),
              );
            },
          );
        },
      );
    },
  );
}


showUploadPortrait<T>(BuildContext context){
   showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    clipBehavior: Clip.none,
    isDismissible: true,
    builder: (BuildContext context) {
      return const UploadPortrait();
    },
  );
}

showDm(BuildContext context,MatchUserInfo info,VoidCallback next){
  showModalBottomSheet(context: context,
      isScrollControlled: true,
      builder: (c){
    TextEditingController controller=TextEditingController();
    return Dm_dialog_content(controller: controller,next: next, info: info,);
  });

}

void showMatched(BuildContext context,{required MatchUserInfo target,required VoidCallback next}) {
  showGeneralDialog(context: context,
      pageBuilder: (_,__,___){
    return MatchedContent(target: target,next: next,);
  });
}

Future showDuoSnapDialog(BuildContext context,{required MatchUserInfo target}){
 return showModalBottomSheet(
    context: context,
    isScrollControlled:true,
    builder: (BuildContext context) {
      return CustomBottomDialog(
        title: 'Duo Snap',
        target: target,
        onClosePressed: () {
          Navigator.of(context).pop(); // 关闭 BottomDialog
        },
      );
    },
  );
}
showDuoSnapTip(BuildContext context,{required Widget child,required double dialogHeight}){
  showModalBottomSheet(context: context, builder: (b){
    return Container(
      height: dialogHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24)
          ),
          border: Border(
            top: BorderSide(width: 4.0, color: Colors.black), // 添加黑色顶部边框
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: child
      ),
    );
  },
  );
}
Future showDuoSnapCompleted(BuildContext context,double dialogHeight,Widget child){
 return showModalBottomSheet(context: context,
      builder: (b){
    return Container(
      height: dialogHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24)
          ),
          border: Border(
            top: BorderSide(width: 4.0, color: Colors.black), // 添加黑色顶部边框
          )
      ),
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: child
      ),
    );
  },
  isScrollControlled: true
  );
}