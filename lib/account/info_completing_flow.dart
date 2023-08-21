import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/user_info.dart';
import 'package:sona/account/services/info.dart';

import '../core/persona/widgets/sona_message.dart';
import '../core/providers/token.dart';
import '../utils/providers/dio.dart';

class InfoCompletingFlow extends ConsumerStatefulWidget {
  const InfoCompletingFlow({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoCompletingFlowState();
}

class _InfoCompletingFlowState extends ConsumerState<InfoCompletingFlow> {

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

  final _interested = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            _name(),
            _genderNAge(),
            _purpose(),
            _photo()
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
            SizedBox(height: 36),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    if (_nameKey.currentState!.validate()) {
                      _pageController.animateToPage(1, duration: const Duration(microseconds: 400), curve: Curves.ease);
                    }
                  },
                  icon: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).colorScheme.primary)
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_forward_rounded)
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _genderNAge() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90),
        child: Form(
          key: _genderNAgeKey,
          child: Column(
            children: [
              const SonaMessage(content: 'I’m Sona. I Will blablabla\nWould you mind telling me your\ngender and age?'),
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
              SizedBox(height: 36),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      if (_genderNAgeKey.currentState!.validate()) {
                        _pageController.animateToPage(2, duration: const Duration(microseconds: 400), curve: Curves.ease);
                      }
                    },
                    icon: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).colorScheme.primary)
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_forward_rounded)
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _purpose() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SonaMessage(content: 'When you meet people here,\nwhat are you most interested in?'),
              SizedBox(height: 36),
              Padding(
                padding: EdgeInsets.only(left: 90, right: 20),
                child: Column(
                  children: [
                    Align(alignment: Alignment.centerLeft, child: Text('Pick at least three')),
                    SizedBox(height: 8),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1
                      ),
                      children: [
                        ...['交友目的', '旅行喜好', 'Youtube/Ins/Tiktok\n的关注', '个人爱好', '音乐/电影/书籍', '时尚'].map<Widget>((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_interested.contains(e)) {
                                _interested.remove(e);
                              } else {
                                _interested.add(e);
                              }
                            });
                          },
                          child: GridTile(child: Container(
                            decoration: BoxDecoration(
                              color: _interested.contains(e) ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.tertiaryContainer
                            ),
                            alignment: Alignment.center,
                            child: Text(e)
                          )),
                        ))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 36),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      if (_interested.length >= 3) {
                        _pageController.animateToPage(3, duration: const Duration(microseconds: 400), curve: Curves.ease);
                      }
                    },
                    icon: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).colorScheme.primary)
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_forward_rounded)
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _photo() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90),
        child: Form(
          child: Column(
            children: [
              const SonaMessage(content: 'Share a photo of yourself \nto \nstart connecting with people'),
              SizedBox(height: 36),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: 158,
                  height: 88,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  alignment: Alignment.center,
                  child: Text('拍照'),
                ),
              ),
              SizedBox(height: 36),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: 158,
                  height: 88,
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  alignment: Alignment.center,
                  child: Text('相册'),
                ),
              ),
              SizedBox(height: 36),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () async {
                      final name = _nameController.text;
                      final dio = ref.read(dioProvider);
                      final info = MyInfo(name: name, gender: int.tryParse(_genderController.text), age: _ageController.text, avatar: 'avatar');
                      try {
                        await updateMyInfo(httpClient: dio, info: info);
                      } on Exception catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                    icon: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Theme.of(context).colorScheme.primary)
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_forward_rounded)
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}