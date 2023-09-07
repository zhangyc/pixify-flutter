import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/models/user.dart';

class UserCard extends StatefulWidget {
  const UserCard(
      {super.key,
      required this.user,
      required this.onLike,
      required this.onArrow});
  final UserInfo user;
  final void Function() onLike;
  final void Function() onArrow;

  @override
  State<StatefulWidget> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final _pageController = PageController();
  double _page = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pageController.addListener(_pageControllerListener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageControllerListener);
    super.dispose();
  }

  _pageControllerListener() {
    _page = _pageController.page ?? 0;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _userInfo();
              } else if (index == 1) {
                return _userBio();
              } else {
                return _userPhoto(widget.user.photos[index - 1]);
              }
            },
            itemCount: widget.user.photos.length + 1,
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 20,
            right: 20,
            height: 5,
            child: Row(
              children: List.generate(
                  widget.user.photos.length + 1,
                  (index) => Flexible(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          height: 3,
                          color: index == _page.round()
                              ? Colors.white54
                              : Colors.black26))),
            )),
        Positioned(
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.secondaryContainer)),
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primaryContainer,
                size: 33,
              ),
              onPressed: widget.onLike,
            ),
          ),
        )
      ],
    );
  }

  Widget _userInfo() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(
                widget.user.photos.firstOrNull ?? ''),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            isAntiAlias: true),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
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
            bottom: MediaQuery.of(context).viewInsets.bottom + 160),
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
        child: Text(widget.user.bio ?? 'no bio',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                shadows: const <Shadow>[
                  Shadow(
                    blurRadius: 5.0,
                    color: Color.fromARGB(10, 0, 0, 0),
                  ),
                ])));
  }

  Widget _userPhoto(String url) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(url),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            isAntiAlias: true),
      ),
    );
  }
}
