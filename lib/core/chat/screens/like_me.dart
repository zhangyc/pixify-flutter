import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sona/account/models/age.dart';

import '../../../common/models/user.dart';

class LikeMeScreen extends StatefulWidget {
  const LikeMeScreen({super.key, required this.data});
  final List<UserInfo> data;

  @override
  State<StatefulWidget> createState() => _LikeMeScreenState();
}

class _LikeMeScreenState extends State<LikeMeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE74E27),
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(CupertinoIcons.back, color: Colors.white,),
        ),
        centerTitle: true,
        title: Text('${widget.data.length} liked you', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1080/1920
        ),
        itemBuilder: _itemBuilder,
        itemCount: widget.data.length
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final u = widget.data[index];
    return Container(
      key: ValueKey(u.id),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(u.avatar!),
          alignment: Alignment.center,
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(4)
      ),
      child: Stack(
        children: [
          Positioned(
            left: 4,
            bottom: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  u.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color.fromARGB(120, 0, 0, 0),
                        )
                      ]
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  u.birthday!.toAge().toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        blurRadius: 2.0,
                        color: Color.fromARGB(120, 0, 0, 0),
                      )
                    ]
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}