import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/screens/profile.dart';
import 'package:sona/core/persona/widgets/sona_message.dart';
import 'package:sona/setting/screens/setting.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/text/gradient_colored_text.dart';
import 'package:sona/utils/global/global.dart';

import '../../../utils/dialog/input.dart';

class PersonaScreen extends StatefulHookConsumerWidget {
  const PersonaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends ConsumerState<PersonaScreen> with AutomaticKeepAliveClientMixin {

  var _controller = TextEditingController();
  String? _currentCharacter;
  List<String> _knowledge = [];

  @override
  void initState() {
    _fetchKnowledge();
    super.initState();
  }

  Future _fetchKnowledge() async {
    // final dio = ref.read(dioProvider);
    // final resp = await dio.get('/knowledge');
    // final data = resp.data;
    // if (data['code'] == 1) {
    //   if (mounted) {
    //     setState(() {
    //       _knowledge = List<String>.from(data['data']);
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _goSetting, icon: Icon(Icons.settings))
        ],
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const GradientColoredText(
                      text: 'SONA',
                      style: TextStyle(
                        fontSize: 50,
                        letterSpacing: 12.0,
                      )
                  ),
                  Container()
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColoredButton(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (_) => const ProfileScreen()
                        )),
                        text: 'My Profile'
                    ),
                    SizedBox(height: 5),
                    ColoredButton(onTap: () => null, text: 'Sona Status'),
                    SizedBox(height: 5),
                    ColoredButton(onTap: () => null, text: 'Becoming Super Sona')
                  ],
                ),
              ),
              SizedBox(height: 24),
              _sonaChat()
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _sonaChat() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SonaMessage(content: 'Hey there! I\'m SONA, your social AI agent!\nThe more you share with me, the better I can help you connect with people.'),
          SonaMessage(content: 'So, Any favorite singers or bands? \nI\'d love to hear which artists get you excited!')
        ],
      ),
    );
  }

  void _goSetting() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingScreen()));
  }

  @override
  bool get wantKeepAlive => true;
}