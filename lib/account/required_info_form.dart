import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/core/providers/navigator_key.dart';

import '../core/persona/widgets/sona_message.dart';
import '../utils/dialog/input.dart';
import '../utils/picker/gender.dart';
import '../utils/providers/dio.dart';
import 'models/gender.dart';

class RequiredInfoFormScreen extends ConsumerStatefulWidget {
  const RequiredInfoFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoCompletingFlowState();
}

class _InfoCompletingFlowState extends ConsumerState<RequiredInfoFormScreen> {

  final _pageController = PageController();

  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _nameKey = GlobalKey<FormState>(debugLabel: 'name');

  Gender? _gender;
  DateTime? _birthday;
  String? _avatar;
  final _cropController = CropController();
  List<Map<String, dynamic>> _availableInterests = [];
  final _interested = <String>{};

  bool get _nameValidate => _nameController.text.trim().isNotEmpty && _nameController.text.trim().length < 32;
  bool get _validate => _nameValidate
      && _gender != null
      && _birthday != null
      && _avatar != null
      && _interested.length >= 3;

  @override
  void initState() {
    _fetchAvailableInterests();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future _fetchAvailableInterests() async {
    final dio = ref.read(dioProvider);
    try {
      final resp = await fetchAvailableInterests(httpClient: dio);
      _availableInterests = List<Map<String, dynamic>>.from(resp.data);
      if (mounted) setState(() {});
    } catch(e) {
      //
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            _pageController.previousPage(duration: const Duration(microseconds: 400), curve: Curves.ease);
          },
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
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
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
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
                    _nameFocusNode.unfocus();
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
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
        child: Column(
          children: [
            const SonaMessage(content: 'I’m Sona. I Will blablabla\nWould you mind telling me your\ngender and age?'),
            SizedBox(height: 36),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 20),
              child: ForwardButton(
                onTap: _onGenderTap,
                text: '性别 ${_gender != null ? _gender?.name : ''}',
              )
            ),
            SizedBox(height: 36),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 20),
              child: ForwardButton(
                onTap: _onBirthdayTap,
                text: '年龄 ${_birthday != null ? _birthday!.toAge() : ''}',
              )
            ),
            SizedBox(height: 36),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    if (_gender == null) {
                      Fluttertoast.showToast(msg: 'Gender is required');
                      return;
                    }
                    if (_birthday == null) {
                      Fluttertoast.showToast(msg: 'Age is required');
                      return;
                    }
                    if (DateTime.now().difference(_birthday!) < const Duration(days: 365 * 12)) {
                      Fluttertoast.showToast(msg: 'The app is not available for under 12');
                      return;
                    }
                    _pageController.animateToPage(2, duration: const Duration(microseconds: 400), curve: Curves.ease);
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

  Widget _purpose() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
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
                        ..._availableInterests.map<Widget>((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_interested.contains(e['code'])) {
                                _interested.remove(e['code']);
                              } else {
                                _interested.add(e['code']!);
                              }
                            });
                          },
                          child: GridTile(child: Container(
                            decoration: BoxDecoration(
                              color: _interested.contains(e['code']) ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.tertiaryContainer
                            ),
                            alignment: Alignment.center,
                            child: Text(e['name']!)
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
                      } else {
                        Fluttertoast.showToast(msg: 'Select 3 or more');
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
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
        child: Form(
          child: Column(
            children: [
              const SonaMessage(content: 'Share a photo of yourself \nto \nstart connecting with people'),
              SizedBox(height: 36),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? file = await picker.pickImage(source: ImageSource.camera);
                  if (file == null) return;
                  _onCropImage(file);
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
                  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                  if (file == null) return;
                  _onCropImage(file);
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
                      if (!_validate) {
                        Fluttertoast.showToast(msg: 'Please check your input');
                        return;
                      }
                      try {
                        await updateMyInfo(
                          httpClient: ref.read(dioProvider),
                          name: _nameController.text,
                          gender: _gender,
                          birthday: _birthday,
                          interests: _interested,
                          avatar: _avatar
                        );
                        ref.read(asyncMyProfileProvider.notifier).refresh();
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

  void _onGenderTap() async {
    _gender = await showGenderPicker(
      context: context,
      title: 'Select your gender'
    );
    setState(() {});
  }

  void _onBirthdayTap() async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 208,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              width: 30,
              height: 3,
              color: Colors.black12,
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 108,
              child: CupertinoDatePicker(
                initialDateTime: DateTime(2000, 12, 30),
                mode: CupertinoDatePickerMode.date,
                showDayOfWeek: true,
                onDateTimeChanged: (DateTime newDate) {
                  _birthday = newDate;
                },
                itemExtent: 40
              ),
            ),
          ],
        ),
      ),
    );
    setState(() {});
  }

  void _onCropImage(XFile file) async {
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 600,
                width: MediaQuery.of(context).size.width,
                child: Crop(
                  image: bytes,
                  aspectRatio: 600 / 848,
                  controller: _cropController,
                  onCropped: (croppedData) async {
                    _avatar = await uploadFile(httpClient: ref.read(dioProvider), bytes: croppedData, filename: file.name);
                    if (!mounted) return;
                    Navigator.pop(context);
                    if (mounted) setState(() {});
                  },
                  initialSize: 0.5,
                  // maskColor: _isSumbnail ? Colors.white : null,
                  cornerDotBuilder: (size, edgeAlignment) => const SizedBox.shrink(),
                  interactive: true,
                  fixArea: true,
                  radius: 16,
                  initialAreaBuilder: (rect) {
                    return Rect.fromLTRB(
                      rect.left + 24,
                      rect.top - 24 * 848 / 600,
                      rect.right - 24,
                      rect.bottom + 24 * 848 / 600
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              ColoredButton(
                  onTap: () {
                    _cropController.crop();
                  },
                  text: 'done'
              )
            ],
          ),
        )
    );
  }
}