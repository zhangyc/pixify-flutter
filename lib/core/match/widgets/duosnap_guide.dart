import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';

class DuosnapGuide extends StatelessWidget {
  const DuosnapGuide({super.key, required this.close});
  final Function close;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.current.newGameplay,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
            ),
            // IconButton(
            //   icon: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
            //   onPressed: (){
            //     close.call();
            //   },
            // ),
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
        SizedBox(
          height: 12,
        ),
        Text(S.current.aiCreatingFunGroupPics,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 12,
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(S.current.checkItOut),
          style: OutlinedButton.styleFrom(backgroundColor: Color(0xffffffff)),
        )
      ],
    );
  }
}
