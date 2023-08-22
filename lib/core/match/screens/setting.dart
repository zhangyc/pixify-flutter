import 'package:flutter/material.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/utils/picker/gender.dart';

class MatchSettingScreen extends StatefulWidget {
  const MatchSettingScreen({super.key});

  @override
  State<MatchSettingScreen> createState() => _MatchSettingScreenState();
}

class _MatchSettingScreenState extends State<MatchSettingScreen> {
  Gender _gender = Gender.female;
  RangeValues _ageRange = RangeValues(18, 38);

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
                final g = await showGenderPicker(context: context, initialValue: _gender);
                if (g != null && g != _gender) {
                  setState(() {
                    _gender = g;
                  });
                }
              },
              text: '显示  ${_gender.name}'
            ),
            SizedBox(height: 16),
            ForwardButton(
                onTap: () { },
                text: '年龄  ${_ageRange.start.toInt()} - ${_ageRange.end.toInt()}'
            ),
            SizedBox(height: 8),
            RangeSlider(
              min: 14,
              max: 60,
              values: _ageRange,
              onChanged: (rv) {
                setState(() {
                  _ageRange = rv;
                });
              }
            )
          ],
        ),
      ),
    );
  }
}
