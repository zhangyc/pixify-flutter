import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
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
        Text(S.of(context).wishes,style: TextStyle(
            color: Color(0xff2c2c2c),
            fontWeight: FontWeight.w800,
            fontSize: 20
        ),),
        const SizedBox(
          height: 16,
        ),
        ...widget.wishes.map((e) => Container(
          margin: const EdgeInsets.only(
              bottom: 16
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: e.pic==null?null:DecorationImage(image: CachedNetworkImageProvider(e.pic!,),fit: BoxFit.cover),
          ),
          child: Container(

            padding: const EdgeInsets.all(16),
            height: 257,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),

              gradient: LinearGradient(colors: [
                Colors.transparent,
                Color(0xff000000).withOpacity(0.75)
              ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              ),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${e.activityNames??''}',style: const TextStyle(
                  color: Colors.white
                ),),
                Text('${e.cityName}、${e.countryName}',style: const TextStyle(
                    color: Colors.white
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${e.timeType}',style: const TextStyle(
                        color: Colors.white
                    ),),
                    Text('${e.countryFlag}')
                  ],
                )

              ],
            ),
          ),
        ))
      ],
    );
  }
}




