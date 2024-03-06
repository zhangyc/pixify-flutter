import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/providers/subscriptions.dart';
import '../../subscribe/subscribe_page.dart';

class TimeLimitedOffer extends StatelessWidget {
  const TimeLimitedOffer({super.key, required this.close});
  final Function close;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.clubPromotionTitle,
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
        SvgPicture.asset(Assets.svgC,width: 120,height: 120,),
        SizedBox(
          height: 16,
        ),
        Text(S.current.clubFeePrefix,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
        ),
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Container(
              alignment: Alignment.center,
              child: ref.watch(asyncSubscriptionsProvider).when(
                  data: (subscriptions) {
                    final club = subscriptions.firstWhere((sub) => sub.id == clubMonthlyId);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          alignment: Alignment.center,
                          child: Text('${club.price}/mo',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 32
                              )
                          ),
                        ),
                      ],
                    );
                  } ,
                  error: (_, __) => Container(),
                  loading: () => const SizedBox(width: 32, height: 32, child: CircularProgressIndicator())
              )
          );
        },),
        Text(" 😉 ${S.current.clubFeeJoking}",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 16,
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
