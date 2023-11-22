import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sona/common/models/user.dart';

import '../../../utils/country/country.dart';

class HeardItem extends StatelessWidget {
  const HeardItem({super.key, required this.userInfo});
  final UserInfo userInfo;
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
              children: [
                Text(userInfo.name??'',style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                 ),
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(userInfo.name??'',style: TextStyle(
                            color: Colors.white,
                            fontSize: 28
                        ),),
                        Text('${userInfo.age??''}',style: TextStyle(
                            color: Colors.white,
                            fontSize: 28
                        ),),
                      ],
                    ),
                    userInfo.country!=null?Text(findFlagByCountryCode(userInfo.country!)):Container()
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on,color: Colors.white,),
                    Text('${userInfo.country}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
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

