import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../bean/match_user.dart';


class WishListItem extends StatefulWidget {
  const WishListItem({super.key, required this.wishes});
  final List<WishBean> wishes;
  @override
  State<WishListItem> createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  @override
  void initState() {
    //getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return widget.wishes.isEmpty?Container():Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Her wishes',style: TextStyle(
            color: Colors.black
        ),),
        SizedBox(
          height: 16,
        ),
        ...widget.wishes.map((e) => Container(
          padding: EdgeInsets.all(16),
          height: 257,
          margin: EdgeInsets.only(
            bottom: 16
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.black26
            ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: e.pic==null?null:DecorationImage(image: CachedNetworkImageProvider(e.pic!,),fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${e.activityNames??''}',style: TextStyle(
                color: Colors.white
              ),),
              Text('${e.cityName}、${e.countryName}',style: TextStyle(
                  color: Colors.white
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${e.timeType}',style: TextStyle(
                      color: Colors.white
                  ),),
                  Text('${e.countryFlag}')
                ],
              )

            ],
          ),
        ))
      ],
    );
  }
  // List<WishBean> ws=[];
  // void getData() async{
  //   HttpResult result=await post('/travel-wish/find',data: {
  //   "page":"1",
  //   "pageSize":3,
  //   "userId":widget.id // 查询用户ID
  //   });
  //   if(result.isSuccess){
  //     List l=result.data['list'];
  //     ws=l.map((e) => WishBean.fromJson(e)).toList();
  //     setState(() {
  //
  //     });
  //   }
  //   print(result);
  // }
}




