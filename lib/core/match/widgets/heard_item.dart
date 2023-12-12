import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sona/core/match/widgets/heard_init_animation.dart';

import '../bean/match_user.dart';

class HeardItem extends StatelessWidget {
  const HeardItem({super.key, required this.userInfo});
  final MatchUserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          userInfo.avatar==null?Container():CachedNetworkImage(imageUrl: userInfo.avatar!,fit: BoxFit.cover,width: MediaQuery.of(context).size.width-16*2,height: 457,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(userInfo.originNickname??'',style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800
                 ),
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width-16*2-16*2-21,
                      child: Text('${userInfo.name??''}, ${userInfo.age}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800
                      ),
                        maxLines: 2,
                      ),
                    ),
                    userInfo.countryFlag!=null?Text(userInfo.countryFlag??''):Container()
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on,color: Colors.white,),
                    Text('${userInfo.currentCity}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900
                    ),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

