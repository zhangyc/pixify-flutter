import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/models/user.dart';

class CardStack extends StatefulWidget {
  final Function onCardChanged;
  final List<UserInfo> user;
  CardStack({required this.onCardChanged, required this.user});
  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack>
    with SingleTickerProviderStateMixin {
  List<TouristCard> cards=[];
  // var cards = List.generate(100, (index) => TouristCard(index: index,
  //     imageUrl: index%2==0?"https://i.acgdir.com/upload/2022/1013/113530_45726.jpg":"https://i.acgdir.com/upload/2022/1013/113530_71027.jpg"));
  late int currentIndex;
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;
  late  Animation<Offset> _translationAnim;
  late  Animation<Offset> _moveAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    // cards=widget.user;
    cards=List.generate(widget.user.length, (index) => TouristCard(index: index, user: widget.user[index]));
    currentIndex = 0;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    curvedAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    _translationAnim = Tween(begin: Offset(0.0, 0.0), end: Offset(-1000.0, 0.0))
        .animate(controller)
      ..addListener(() {
        setState(() {});
      });

    _scaleAnim = Tween(begin: 0.965, end: 1.0).animate(curvedAnimation);
    _moveAnim = Tween(begin: Offset(0.0, 0.05), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: cards.reversed.map((card) {
          if (cards.indexOf(card) <= 2) {
            return GestureDetector(
              // onVerticalDragStart: _onVerticalDragStart,
              onHorizontalDragEnd: _horizontalDragEnd,
              child: Transform.translate(
                offset: _getFlickTransformOffset(card),
                child: FractionalTranslation(
                  translation: _getStackedCardOffset(card),
                  child: Transform.scale(
                    scale: _getStackedCardScale(card),
                    child: Center(child: card),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        }).toList());
  }

  Offset _getStackedCardOffset(TouristCard card) {
    int diff = card.index - currentIndex;
    if (card.index == currentIndex + 1) {
      return _moveAnim.value;
    } else if (diff > 0 && diff <= 2) {
      return Offset(0.0, 0.05 * diff);
    } else {
      return Offset(0.0, 0.0);
    }
  }

  double _getStackedCardScale(TouristCard card) {
    int diff = card.index - currentIndex;
    if (card.index == currentIndex) {
      return 1.0;
    } else if (card.index == currentIndex + 1) {
      return _scaleAnim.value;
    } else {
      return (1 - (0.035 * diff.abs()));
    }
  }

  Offset _getFlickTransformOffset(TouristCard card) {
    if (card.index == currentIndex) {
      return _translationAnim.value;
    }
    return Offset(0.0, 0.0);
  }

  void _horizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity! < 0) {
      // Swiped Right to Left
      controller.forward().whenComplete(() {
        setState(() {
          controller.reset();
          TouristCard removedCard = cards.removeAt(0);
          cards.add(removedCard);
          currentIndex = cards[0].index;
          widget.onCardChanged(cards[0].user.avatar);
        });
      });
    }
  }

  void _onVerticalDragStart(DragStartDetails details) {
  }
}

class TouristCard extends StatelessWidget {
  final int index;
  // final String imageUrl;
  final UserInfo user;
  TouristCard({required this.index, required this.user});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(children: [
          CachedNetworkImage(imageUrl: user.avatar??"",height: 350,width: 350,fit: BoxFit.cover,),
          FractionalTranslation(
            translation: Offset(1.7, -0.5),
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.yellow,
              child: Icon(Icons.star),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Tourist Spot",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Travel and Recreation",
            ),
          ),
          TextButton(
            child: Text(
              "EXPLORE",
            ),

            onPressed: () {},
          )
        ]),
      ),
    );
  }
}