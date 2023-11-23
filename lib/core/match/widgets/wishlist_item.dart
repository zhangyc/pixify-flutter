import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sona/core/match/util/http_util.dart';

class WishListItem extends StatefulWidget {
  const WishListItem({super.key, required this.id});
  final String id;
  @override
  State<WishListItem> createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ws.isEmpty?Container():Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Her wishes',style: TextStyle(
            color: Colors.black
        ),),
        SizedBox(
          height: 16,
        ),
        ...ws.map((e) => Container(
          padding: EdgeInsets.all(16),
          height: 257,
          margin: EdgeInsets.only(
            bottom: 16
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: e.pic==null?null:DecorationImage(image: CachedNetworkImageProvider(e.pic!,),fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${e.activityNames}'),
              Text('${e.cityName}、${e.countryName}'),
              Row(
                children: [
                  Text('${e.timeType}'),
                  Text('${e.countryName}')
                ],
              )

            ],
          ),
        ))
        // Container(
        //   padding: EdgeInsets.all(12),
        //   width: MediaQuery.of(context).size.width-16*2,
        //   decoration: BoxDecoration(
        //     color: Color(0xff2c2c2c),
        //     borderRadius: BorderRadius.circular(24),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: ws.map((e) => Container(
        //       decoration: BoxDecoration(
        //         image: e.pic==null?null:DecorationImage(image: CachedNetworkImageProvider(e.pic!,),fit: BoxFit.cover),
        //       ),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           Text('${e.activityNames}'),
        //           Text('${e.cityName}、${e.countryName}'),
        //           Row(
        //             children: [
        //               Text('${e.timeType}'),
        //               Text('${e.countryName}')
        //             ],
        //           )
        //
        //         ],
        //       ),
        //     )).toList()
        //   ),
        // )
      ],
    );
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width-16*2,
      decoration: BoxDecoration(
        color: Color(0xff2c2c2c),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Her wishes',style: TextStyle(
            color: Colors.white
          ),),
          ...ws.map((e) => Container(
            decoration: BoxDecoration(
              image: e.pic==null?null:DecorationImage(image: CachedNetworkImageProvider(e.pic!)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${e.activityNames}'),
                Text('${e.cityName}、${e.countryName}'),
                Row(
                  children: [
                    Text('${e.timeType}'),
                    Text('${e.countryName}')
                  ],
                )

              ],
            ),
          ))
        ],
      ),
    );
  }
  List<WishBean> ws=[];
  void getData() async{
    HttpResult result=await post('/travel-wish/find',data: {
    "page":"1",
    "pageSize":3,
    "userId":widget.id // 查询用户ID
    });
    if(result.isSuccess){
      List l=result.data['list'];
      ws=l.map((e) => WishBean.fromJson(e)).toList();
      setState(() {

      });
    }
    print(result);
  }
}
class WishBean {
  int? id;
  int? createDate;
  int? modifyDate;
  int? userId;
  String? title;
  int? countryId;
  String? countryName;
  String? cityId;
  String? cityName;
  String? pic;
  String? timeType;
  int? endDate;
  String? activityIds;
  String? activityNames;
  int? status;

  WishBean(
      {this.id,
        this.createDate,
        this.modifyDate,
        this.userId,
        this.title,
        this.countryId,
        this.countryName,
        this.cityId,
        this.cityName,
        this.pic,
        this.timeType,
        this.endDate,
        this.activityIds,
        this.activityNames,
        this.status});

  WishBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    modifyDate = json['modifyDate'];
    userId = json['userId'];
    title = json['title'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    pic = json['pic'];
    timeType = json['timeType'];
    endDate = json['endDate'];
    activityIds = json['activityIds'];
    activityNames = json['activityNames'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['modifyDate'] = this.modifyDate;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['pic'] = this.pic;
    data['timeType'] = this.timeType;
    data['endDate'] = this.endDate;
    data['activityIds'] = this.activityIds;
    data['activityNames'] = this.activityNames;
    data['status'] = this.status;
    return data;
  }
}



