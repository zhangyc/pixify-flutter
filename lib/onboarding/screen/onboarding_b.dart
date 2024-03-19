import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/utils/global/global.dart';

import '../../generated/l10n.dart';

class OnboardingScreenB extends StatefulWidget {
  const OnboardingScreenB({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreenB> {

  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size.zero)
              ),
              onPressed: _onSkip,
              child: Text('Skip')
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFBEFF06),
            image: DecorationImage(
                image: AssetImage('assets/images/onboarding_b_bg.png'),
                fit: BoxFit.cover
            )
        ),
        child: PageView(
          controller: _controller,
          // onPageChanged: (index) {
          //   if (index == 3) {
          //     SonaAnalytics.log('reg_intro_last');
          //   }
          // },
          children: [
            ...[0].map((i) => _itemBuilder(i)),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(bottom: 80),
      //   padding: EdgeInsets.all(16),
      //   child: SmoothPageIndicator(
      //     controller: _controller,
      //     count: 4,
      //     axisDirection: Axis.horizontal,
      //     effect: ExpandingDotsEffect(
      //         spacing: 8.0,
      //         radius: 4.0,
      //         dotWidth: 16.0,
      //         dotHeight: 8.0,
      //         paintStyle: PaintingStyle.fill,
      //         strokeWidth: 1.5,
      //         dotColor: Color(0xFFE8E6E6),
      //         activeDotColor: Theme.of(context).primaryColor
      //     ),
      //   ),
      // ),
    );
  }

  Widget _itemBuilder(int index) {
    return Container(
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: <Widget>[
          Positioned.fill(
              bottom: 80,
              child: Image.asset('assets/images/onboarding_b.png', fit: BoxFit.fitWidth)
          ),
          Positioned(
              left: -60,
              right: -60,
              top: MediaQuery.of(context).size.height / 2 + 50,
              child: Image.asset('assets/images/onboarding_fg.png', fit: BoxFit.fitWidth)
          ),
          Positioned(
              left: 12,
              right: 12,
              top: MediaQuery.of(context).size.height / 2 + 120,
              child: Text(
                switch(index) {
                  0 => S.current.onboardingB,
                  _ => '',
                },
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              )
          ),
          switch(index) {
            0 => Positioned(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16,
                child: OutlinedButton(
                  onPressed: _onSkip,
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color(0xFFBEFF06))
                  ),
                  child: Text('Let\'s go!'),
                )
            ),
            _ => Container(),
          }
        ],
      ),
    );
  }

  void _onSkip() {
    kvStore.setBool('onboarding', true);
    Navigator.pushReplacementNamed(context, 'login');
  }

  void _onNext() {
    _controller.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }
}