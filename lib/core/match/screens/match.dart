import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/models/user_model.dart';
import 'package:sona/core/persona/models/user.dart';
import 'package:sona/utils/providers/dio.dart';

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  late AppinioSwiperController _controller;
  final avatar = 'assets/kael.jpeg';
  var _s = <UserModel>[
//     UserModel(
//       birthday: 1691481271000,
//       gender: 1,
//       chatStyleId: 3,
//       nickname: '刘亦菲',
//       description: '啦啦啦啦',
//       id: 2,
//       avatar: 'https://cdn.hk01.com/di/media/images/dw/20200812/370289758980673536.jpeg/n9DPEMxK9oiurOikNCKS0vCbRRiCES0RUTjuFlE47hY?v=w1920',
//       images: [
// "https://cdn.hk01.com/di/media/images/dw/20200812/370289758980673536.jpeg/n9DPEMxK9oiurOikNCKS0vCbRRiCES0RUTjuFlE47hY?v=w1920"
//       ]
//     )
  ];
  @override
  void initState() {
    _controller = AppinioSwiperController();
    _loadMore();
    super.initState();
  }
  UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Match'),
        actions: [
          IconButton(onPressed: (){
                setState(() {

                });
           }, icon: Icon(Icons.filter_alt))
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AppinioSwiper(
                controller: _controller,
                cardsCount: _s.length,

                onSwipe: (int index, AppinioSwiperDirection direction) {
                  // if (index >= _s.length - 3) {
                  //   _loadMore();
                  // }
                  userModel = _s[index];
                  switch (direction) {
                    case AppinioSwiperDirection.left:
                      _leftSwipeHandler(userModel!);
                    case AppinioSwiperDirection.right:
                      _rightSwipeHandler(userModel!);
                    case AppinioSwiperDirection.top || AppinioSwiperDirection.bottom:
                      _verticalSwipeHandler(userModel!);
                    default:
                      _swipeExceptionHandler(index, direction, userModel!);
                  }
                  setState(() {

                  });
                },
                onEnd: () {
                  print('onEnd');
                },
                cardsBuilder: (BuildContext context,int index){
                   userModel= _s[index];
                  // List<String> images
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(userModel?.avatar??''),
                            fit: BoxFit.cover,
                            alignment: Alignment.center
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    clipBehavior: Clip.antiAlias,
                    alignment: Alignment.bottomCenter,
                    // child: TextButton(
                    //     child: Container(
                    //         height: 42,
                    //         width: 78,
                    //         alignment: Alignment.center,
                    //         color: Colors.white,
                    //         child: Text('Hang')
                    //     ),
                    //     onPressed: () {}
                    // )
                  );
                  return Column(
                    children: [


                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${userModel?.nickname}'),
                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
              ],
            ),
            Container(
              height: 100,
              child: Text('${userModel?.description}'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xffF6C6FF),
                  borderRadius: BorderRadius.circular(60)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    ref.read(dioProvider).post('/user/update-relation',data: {
                      'userId':userModel?.id,
                      'relationType':RelationType.ignore.value
                    });
                    _s.remove(userModel);
                    setState(() {

                    });
                   }, icon: Icon(Icons.close,size: 36,)),
                  IconButton(onPressed: (){
                    ref.read(dioProvider).post('/user/update-relation',data: {
                      'userId':userModel?.id,
                      'relationType':RelationType.like.value
                    });

                  }, icon: Icon(Icons.monitor_heart_rounded,size: 36,)),
                  IconButton(onPressed: (){
                    ref.read(dioProvider).post('/user/update-relation',data: {
                      'userId':userModel?.id,
                      'relationType':RelationType.arrow.value
                    });
                  }, icon: Icon(Icons.connect_without_contact_outlined,size: 36,)),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }

  Future _loadMore() async {
    final dio = ref.read(dioProvider);
    final resp = await dio.post('/user/match',data: {
      "page":1,
      "pageSize":50
    });
    final data = resp.data;
    if(data!=null){
      final d = data['list'] as List;
      final users = d.map<UserModel>((e) => UserModel.fromJson(e)..avatar='https://img.zcool.cn/community/01ecdf59e70865a801202b0c236fcb.jpg@1280w_1l_2o_100sh.jpg').toList();
      _s =users;
      setState(() {});
    }
    // if (data['code'] == "0") {
    //
    // }
  }

  Future _leftSwipeHandler(UserModel user) async {
    final dio = ref.read(dioProvider);
    final resp = await dio.post('/chat', data: user.toJson());
    final data = resp.data;
    if (data['code'] == 1) {
      Fluttertoast.showToast(msg: '已添加');
    }
    // showCupertinoModalPopup(
    //     context: context,
    //     semanticsDismissible: true,
    //     builder: (_) => SafeArea(
    //       child: Container(
    //           decoration: BoxDecoration(
    //               color: Colors.white,
    //               image: DecorationImage(
    //                   image: AssetImage(path),
    //                   fit: BoxFit.cover,
    //                   alignment: Alignment.center
    //               ),
    //               borderRadius: BorderRadius.circular(20)
    //           ),
    //           clipBehavior: Clip.antiAlias,
    //           alignment: Alignment.bottomCenter,
    //           child: const FittedBox(
    //             alignment: Alignment.center,
    //             child: Text(
    //                 '❤️ Matched',
    //                 strutStyle: StrutStyle(),
    //                 style: TextStyle(
    //                   fontSize: 52,
    //                   color: Colors.amberAccent,
    //                   fontWeight: FontWeight.w700,
    //                   decoration: TextDecoration.none
    //                 )
    //             )
    //           )
    //       ),
    //     )
    // );
  }

  void _rightSwipeHandler(UserModel user) {
    print('swipe-right');
  }

  void _verticalSwipeHandler(UserModel user) {

  }

  void _swipeExceptionHandler(int index, AppinioSwiperDirection direction, UserModel user) {

  }
}
enum RelationType{
  ignore(label:'ignore',value:1),
  like(label:'like',value:2),
  arrow(label:'arrow',value:3);
  const RelationType({required this.label,required this.value});
  final String label;
  final int value;
}