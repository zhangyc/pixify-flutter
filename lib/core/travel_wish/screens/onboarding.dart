import 'package:flutter/material.dart';
import 'package:sona/account/widgets/typwriter.dart';
import 'package:sona/core/travel_wish/screens/travel_wish_creator.dart';

import '../../../generated/l10n.dart';


class TravelWishOnboardingScreen extends StatefulWidget {
  const TravelWishOnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TravelWishOnboardingScreenState();
}

class _TravelWishOnboardingScreenState extends State<TravelWishOnboardingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_bg.png'),
            fit: BoxFit.cover
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/onboarding_2.png'),
                fit: BoxFit.cover
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Typwriter(
              textBuilder: () => S.of(context).onboardingWish,
              highlights: [],
              duration: const Duration(milliseconds: 60),
              onDone: () {
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => TravelWishCreator(first: true)), (route) => false));
              },
            ),
          ),
        ),
      ),
    );
  }
}