import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/screens/match.dart';

import '../../../account/providers/profile.dart';
import '../../../common/models/user.dart';
import '../../../generated/assets.dart';
import '../../providers/navigator_key.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/matched.dart';
import 'match_init_animation.dart';

class UserCard extends ConsumerStatefulWidget {
  UserCard({
    super.key,
    required this.user,
    this.actions = const <Positioned>[],
    this.onArrow,
  });
  final UserInfo user;
  final List<Positioned> actions;
  Function? onArrow;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConsumerUserCardState();
}

class _ConsumerUserCardState extends ConsumerState<UserCard> with SingleTickerProviderStateMixin{
  final _pageController = PageController();
  double _page = 0;
  late AnimationController arrowController;

  @override
  void initState() {
    arrowController=AnimationController(vsync: this,duration: Duration(milliseconds: 1500),lowerBound: 0.1,upperBound: 1);
    arrowController.addListener(() {
      if(arrowController.isCompleted){
        widget.onArrow?.call();
        setState(() {

        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pageController.addListener(_pageControllerListener);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageControllerListener);
    arrowController.dispose();
    super.dispose();
  }

  _pageControllerListener() {
    _page = _pageController.page ?? 0;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasBio = widget.user.bio != null;
    final itemCount = widget.user.photos.length + (hasBio ? 1 : 0);

    return Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _userInfo();
              } else if (index == 1) {
                if (hasBio) {
                  return _userBio();
                } else {
                  return _userPhoto(widget.user.photos[index]);
                }
              } else {
                if (hasBio) {
                  return _userPhoto(widget.user.photos[index - 1]);
                } else {
                  return _userPhoto(widget.user.photos[index]);
                }
              }
            },
            itemCount: itemCount,
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 20,
            right: 20,
            height: 5,
            child: Visibility(
              visible: itemCount > 1,
              child: Row(
                children: List.generate(
                  itemCount,
                  (index) => Flexible(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      color: index == _page.round() ? Colors.white54 : Colors.black26
                    )
                  )
                ),
              ),
            )
        ),
        Positioned.fill(child: Arrow(animationController: arrowController)),

        Positioned(
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 80,
          child:  GestureDetector(child: Image.asset(Assets.iconsArrow,width: 50,height: 50,),
            onTap: (){
              ref.read(asyncMatchRecommendedProvider.notifier)
                  .arrow(widget.user.id).then((resp){
                    print(resp);
                if(resp.statusCode==10150){
                  /// 判断如果不是会员，跳转道会员页面
                  if(ref.read(asyncMyProfileProvider).value?.isMember??false){
                    Navigator.push(ref.read(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder:(c){
                      return SubscribePage();
                    }));
                  }else {
                    Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                  }
                  ///如果是会员，提示超过限制
                }else if(resp.isSuccess){
                  widget.user.arrowed=true;
                  ///内存中取一下
                  arrowController.reset();
                  arrowController.forward();

                }
              });

               setState(() {

               });
            },
          )
        ),
        ...widget.actions,
      ],
    );
  }

  Widget _userInfo() {
    return Container(
      // decoration: BoxDecoration(
      //
      //   image: DecorationImage(
      //       image: CachedNetworkImageProvider(
      //           widget.user.photos.firstOrNull ?? ''),
      //       fit: BoxFit.cover,
      //       alignment: Alignment.center,
      //       isAntiAlias: true,
      //   ),
      // ),
      // clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          CachedNetworkImage(imageUrl: widget.user.photos.firstOrNull ?? '',
            placeholder: (_,__){
              return Container(child: Center(child: MatchInitAnimation()),color: Colors.black,);
            },
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.user.name}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      shadows: const <Shadow>[
                        Shadow(
                          blurRadius: 5.0,
                          color: Color.fromARGB(10, 0, 0, 0),
                        ),
                      ],
                    )),
                Text('${widget.user.age}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        shadows: const <Shadow>[
                          Shadow(
                            blurRadius: 5.0,
                            color: Color.fromARGB(10, 0, 0, 0),
                          ),
                        ]))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userBio() {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 40,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 160
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(
                widget.user.photos.firstOrNull ?? ''),
            colorFilter:
                const ColorFilter.mode(Colors.black54, BlendMode.srcATop),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            isAntiAlias: true),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.topLeft,
      child: Text(widget.user.bio ?? '',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              shadows: const <Shadow>[
                Shadow(
                  blurRadius: 5.0,
                  color: Color.fromARGB(10, 0, 0, 0),
                ),
              ]
          )
      )
    );
  }

  Widget _userPhoto(String url) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          isAntiAlias: true
        ),
      ),
    );
  }
}
