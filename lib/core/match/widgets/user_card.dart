import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/models/user.dart';
import 'match_init_animation.dart';

class UserCard extends ConsumerStatefulWidget {
  const UserCard({
    super.key,
    required this.user,
    this.actions = const <Positioned>[],
  });
  final UserInfo user;
  final List<Positioned> actions;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConsumerUserCardState();
}

class _ConsumerUserCardState extends ConsumerState<UserCard> with SingleTickerProviderStateMixin{
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
              return Container(color: Colors.black,child: const Center(child: MatchInitAnimation()));
            },
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            cacheManager: DefaultCacheManager(),
          ),
          Positioned(
            left: 20,
            right: 120,
            bottom: MediaQuery.of(context).viewInsets.bottom + 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${widget.user.name}',
                    maxLines: 2,
                    softWrap: true,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      shadows: const <Shadow>[
                        Shadow(
                          blurRadius: 5.0,
                          color: Color.fromARGB(120, 0, 0, 0),
                        ),
                      ],
                    )),
                Text(
                  '${widget.user.age}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      shadows: const <Shadow>[
                        Shadow(
                          blurRadius: 5.0,
                          color: Color.fromARGB(120, 0, 0, 0),
                        ),
                      ]
                  )
                )
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
            isAntiAlias: true
        ),
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
                  color: Color.fromARGB(20, 0, 0, 0),
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
