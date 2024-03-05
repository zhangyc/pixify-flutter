import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../account/providers/profile.dart';
import '../bean/duosnap_task.dart';

class SmallDuoSnap extends StatelessWidget {
  const SmallDuoSnap({super.key, required this.task});
  final DuoSnapTask task;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
            angle: -15 * 3.14 / 180,
            child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Container(
                width: 26,
                height: 35,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    ),
                    image: DecorationImage(image: CachedNetworkImageProvider(ref.read(myProfileProvider)!.avatar??'',),fit: BoxFit.cover,)

                ),
              );
            },)), // 替换为您的左侧图片路径
        Transform.rotate(
            angle: 15 * 3.14 / 180,
            child: Container(
              width: 26,
              height: 35,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  image: DecorationImage(image: CachedNetworkImageProvider(task.targetUserAvatar??''),fit: BoxFit.cover,)
              ),
            )
        ), // 替换为您的右侧图片路径
      ],
    );
  }
}
