import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/account/widgets/typwriter.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/common/widgets/text/colorful_sona.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../core/persona/widgets/sona_message.dart';
import '../../utils/picker/gender.dart';
import '../../utils/providers/dio.dart';
import '../models/gender.dart';

class RequiredInfoFormScreen extends ConsumerStatefulWidget {
  const RequiredInfoFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InfoCompletingFlowState();
}

class _InfoCompletingFlowState extends ConsumerState<RequiredInfoFormScreen> {
  final _pageController = PageController();
  late final List<FieldAcquireAction> _actions;

  String? _name;
  Gender? _gender;
  DateTime? _birthday;
  String? _avatar;
  Set<String> _interests = <String>{};

  bool get _nameValidate =>
      _name != null && _name!.isNotEmpty && _name!.length < 32;
  bool get _validate =>
      _nameValidate &&
      _gender != null &&
      _birthday != null &&
      _avatar != null &&
      _interests.length >= 3;

  @override
  void initState() {
    _initActions();
    super.initState();
  }

  void _initActions() {
    _actions = [
      FieldAcquireAction(
          field: null,
          text:
              'Hi\n\nI\'m SONA😊\n\nYour social advisor to coach you on\nmeaningful friendships!',
          action: null),
      FieldAcquireAction(
          field: 'name', text: 'What\'s your name?', action: _getName),
      FieldAcquireAction(
          field: 'birthday', text: 'How old are you?', action: _getBirthday),
      FieldAcquireAction(
          field: 'gender', text: 'Plz choose your Gender', action: _getGender),
      FieldAcquireAction(
          field: 'avatar',
          text: 'Choose a photo for your avatar',
          action: _getAPhotoAndUpload),
      FieldAcquireAction(
          field: 'interests',
          text: 'Choose your interests',
          action: _chooseInterests),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _actions
              .map((action) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    child: Typwriter(
                        text: action.text,
                        duration: const Duration(milliseconds: 100),
                        onDone: () async {
                          if (action.action != null) {
                            action.value = await action.action!();
                          }
                          if (action.field == 'avatar') {
                            ref
                                .read(asyncMyProfileProvider.notifier)
                                .updateInfo(
                                    name: _name,
                                    birthday: _birthday,
                                    gender: _gender,
                                    avatar: _avatar,
                                    interests: _interests);
                          } else {
                            _pageController.nextPage(
                                duration: const Duration(microseconds: 400),
                                curve: Curves.ease);
                          }
                        }),
                  ))
              .toList(),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Future<String> _getName() async {
    final value = await showSingleLineTextField(context: context, title: null);
    if (value == null) {
      return _getName();
    } else {
      _actions.firstWhere((action) => action.field == 'name')
        ..value = value
        ..done = true;
      _name = value;
      return value;
    }
  }

  Future<DateTime> _getBirthday() async {
    final value = await showBirthdayPicker(
        context: context,
        initialDate: DateTime(2000, 12, 30),
        dismissible: false);
    if (value == null) {
      return _getBirthday();
    } else {
      _actions.firstWhere((action) => action.field == 'birthday')
        ..value = value
        ..done = true;
      _birthday = value;
      return value;
    }
  }

  Future<Gender> _getGender() async {
    final value = await showGenderPicker(context: context, dismissible: false);
    if (value == null) {
      return _getGender();
    } else {
      _actions.firstWhere((action) => action.field == 'gender')
        ..value = value
        ..done = true;
      _gender = value;
      return value;
    }
  }

  Future<String> _getAPhotoAndUpload() async {
    final source = await showRadioFieldDialog(context: context, options: {
      'Choose a photo': ImageSource.gallery,
      'Take a photo': ImageSource.camera
    });
    if (source == null) throw Exception('No source');
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    if (file == null) throw Exception('No file');
    final bytes = await file.readAsBytes();
    final dio = ref.read(dioProvider);
    final value =
        await uploadFile(httpClient: dio, bytes: bytes, filename: file.name);
    _actions.firstWhere((action) => action.field == 'avatar')
      ..value = value
      ..done = true;
    _avatar = value;
    return value;
  }

  Future<Gender> _chooseInterests() async {
    final value = await showDialog(
        context: context, builder: (context) => const InterestsSelector());
    if (value == null) {
      return _getGender();
    } else {
      _actions.firstWhere((action) => action.field == 'interests')
        ..value = value
        ..done = true;
      _interests = value;
      return value;
    }
  }
}

class FieldAcquireAction<T> {
  FieldAcquireAction(
      {required this.field, required this.text, required this.action});
  final String? field;
  String text;
  final Future<T> Function()? action;
  T? value;
  bool done = false;
}

class InterestsSelector extends ConsumerStatefulWidget {
  const InterestsSelector({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InterestsSelectorState();
}

class _InterestsSelectorState extends ConsumerState<InterestsSelector> {
  List<Map<String, dynamic>> _availableInterests = [];
  final _interested = <String>{};

  @override
  void initState() {
    _fetchAvailableInterests();
    super.initState();
  }

  Future _fetchAvailableInterests() async {
    final dio = ref.read(dioProvider);
    try {
      final resp = await fetchAvailableInterests(httpClient: dio);
      _availableInterests = List<Map<String, dynamic>>.from(resp.data);
      if (mounted) setState(() {});
    } catch (e) {
      //
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SonaMessage(
                  content:
                      'When you meet people here,\nwhat are you most interested in?'),
              SizedBox(height: 36),
              Padding(
                padding: EdgeInsets.only(left: 90, right: 20),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Pick at least three')),
                    SizedBox(height: 8),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1),
                      children: [
                        ..._availableInterests
                            .map<Widget>((e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_interested.contains(e['code'])) {
                                        _interested.remove(e['code']);
                                      } else {
                                        _interested.add(e['code']!);
                                      }
                                    });
                                  },
                                  child: GridTile(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: _interested
                                                      .contains(e['code'])
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .tertiaryContainer),
                                          alignment: Alignment.center,
                                          child: Text(e['name']!))),
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
                        Navigator.of(context).pop(_interested);
                      } else {
                        Fluttertoast.showToast(msg: 'Select 3 or more');
                      }
                    },
                    icon: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary)),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_forward_rounded))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
