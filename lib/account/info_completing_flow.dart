import 'package:flutter/material.dart';

import '../core/persona/widgets/sona_message.dart';

class InfoCompletingFlow extends StatefulWidget {
  const InfoCompletingFlow({
    super.key,
    required this.phone,
    required this.pin
  });

  final String phone;
  final String pin;

  @override
  State<StatefulWidget> createState() => _InfoCompletingFlowState();
}

class _InfoCompletingFlowState extends State<InfoCompletingFlow> {

  final _pageController = PageController();

  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _nameKey = GlobalKey<FormState>(debugLabel: 'name');

  final _genderController = TextEditingController();
  final _genderFocusNode = FocusNode();
  final _genderNAgeKey = GlobalKey<FormState>(debugLabel: 'gender and age');

  final _ageController = TextEditingController();
  final _ageFocusNode = FocusNode();
  // final _ageKey = GlobalKey<FormState>(debugLabel: 'birthday');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            _name(),
            _genderNAge(),
            _purpose()
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _name() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90),
      child: Form(
        key: _nameKey,
        child: Column(
          children: [
            const SonaMessage(content: 'We haven\'t been introduced \nwhat\'s your name?'),
            SizedBox(height: 36),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 20),
              child: TextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: const InputDecoration(
                  labelText: 'My name is...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderNAge() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90),
      child: Form(
        key: _genderNAgeKey,
        child: Column(
          children: [
            const SonaMessage(content: 'We haven\'t been introduced \nwhat\'s your name?'),
            SizedBox(height: 36),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 20),
              child: TextField(
                controller: _genderController,
                focusNode: _genderFocusNode,
                decoration: const InputDecoration(
                  labelText: 'My gender is...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 36),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 20),
              child: TextFormField(
                controller: _ageController,
                focusNode: _ageFocusNode,
                decoration: const InputDecoration(
                  labelText: 'My age is...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _purpose() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90),
      child: Form(
        key: _genderNAgeKey,
        child: Column(
          children: [
            const SonaMessage(content: 'When you meet people here,\nwhat are you most interested in?'),
            SizedBox(height: 36),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 20),
              child: Column(
                children: [
                  Text('Pick at least three'),
                  SizedBox(height: 8),
                  GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.5
                    ),
                    children: [
                      ...['交友目的', '旅行喜好'].map<Widget>((e) => GridTile(child: Text(e)))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}