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
  var _s = <UserModel>[];

  @override
  void initState() {
    _controller = AppinioSwiperController();
    _loadMore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Match'),
        actions: [
          IconButton(onPressed: (){

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
                  final user = _s[index - 1];
                  switch (direction) {
                    case AppinioSwiperDirection.left:
                      _leftSwipeHandler(user);
                    case AppinioSwiperDirection.right:
                      _rightSwipeHandler(user);
                    case AppinioSwiperDirection.top || AppinioSwiperDirection.bottom:
                      _verticalSwipeHandler(user);
                    default:
                      _swipeExceptionHandler(index, direction, user);
                  }
                },
                onEnd: () {
                  print('onEnd');
                },
                cardsBuilder: (BuildContext context,int index){
                  UserModel user= _s[index];
                  // List<String> images
                  return Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(user.avatar??''),
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user.nickname}'),
                          IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
                        ],
                      ),
                      Container(
                        height: 100,
                        child: Text('${user.description}'),
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
                                'userId':user.id,
                                'relationType':RelationType.ignore.value
                              });
                            }, icon: Icon(Icons.close,size: 36,)),
                            IconButton(onPressed: (){
                              ref.read(dioProvider).post('/user/update-relation',data: {
                                'userId':user.id,
                                'relationType':RelationType.like.value
                              });
                            }, icon: Icon(Icons.monitor_heart_rounded,size: 36,)),
                            IconButton(onPressed: (){
                              ref.read(dioProvider).post('/user/update-relation',data: {
                                'userId':user.id,
                                'relationType':RelationType.arrow.value
                              });
                            }, icon: Icon(Icons.connect_without_contact_outlined,size: 36,)),
                          ],
                        ),

                      )
                    ],
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future _loadMore() async {
    final dio = ref.read(dioProvider);
    final resp = await dio.post('/user/match');
    final data = resp.data;
    if (data['code'] == 1) {
      final d = data['data'] as List;
      final users = d.map<UserModel>((e) => UserModel.fromJson(e));
      _s = [..._s, ...users];
      setState(() {});
    }
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