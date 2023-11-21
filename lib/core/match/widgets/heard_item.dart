import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sona/common/models/user.dart';

class HeardItem extends StatelessWidget {
  const HeardItem({super.key, required this.userInfo});
  final UserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          userInfo.avatar==null?Container():CachedNetworkImage(imageUrl: userInfo.avatar!,fit: BoxFit.cover,width: MediaQuery.of(context).size.width-16*2,),
          Column(
            children: [
              Text('Maeda Nozomi'),
              Row(
                children: [
                  Text('夕美'),
                  Text('20'),
                  Text('flag')
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on),
                  Text('Tokyo')
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

