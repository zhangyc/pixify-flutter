import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/core/match/providers/setting.dart';
import 'package:sona/utils/picker/gender.dart';

class MatchSettingScreen extends ConsumerStatefulWidget {
  const MatchSettingScreen({super.key});

  @override
  ConsumerState<MatchSettingScreen> createState() => _MatchSettingScreenState();
}

class _MatchSettingScreenState extends ConsumerState<MatchSettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_outlined)
        ),
        title: Text('希望遇到什么样的人呢？'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            ForwardButton(
              onTap: () async {
                final g = await showGenderPicker(
                  context: context,
                  initialValue: ref.read(matchSettingProvider).gender,
                );
                if (g != ref.read(matchSettingProvider).gender) {
                  ref.read(matchSettingProvider.notifier).setGender(g);
                }
              },
              text: '显示  ${ref.watch(matchSettingProvider).gender?.name ?? 'All'}'
            ),
            SizedBox(height: 16),
            ForwardButton(
                onTap: () {},
                text: '年龄  ${ref.watch(matchSettingProvider).ageRange.start.toInt()} - ${ref.watch(matchSettingProvider).ageRange.end.toInt()}'
            ),
            SizedBox(height: 8),
            RangeSlider(
              min: 14,
              max: 60,
              values: ref.watch(matchSettingProvider).ageRange,
              onChanged: (rv) {
                ref.read(matchSettingProvider.notifier).setAgeRange(rv);
              }
            )
          ],
        ),
      ),
    );
  }
}
