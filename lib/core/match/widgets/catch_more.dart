import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';

class CatchMore extends StatelessWidget {
  const CatchMore({super.key, required this.close});
  final Function close;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.catchMore,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
            ),
            IconButton(
              icon: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
              onPressed: (){
                close.call();
              },
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        SvgPicture.asset(Assets.svgDuosnap,width: 120,height: 120,),
        SizedBox(
          height: 12,
        ),
        Text('Duo Snap',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
        ),
        Text(S.current.unmissableSpecialOfferPrices,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 12,
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
              return SubscribePage(fromTag: FromTag.duo_snap,);
            }));
          },
          child: Text(S.current.checkItOut),
          style: OutlinedButton.styleFrom(backgroundColor: Color(0xffBEFF06)),
        )
      ],
    );
  }
}
