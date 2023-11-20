import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/widgets/typwriter.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/utils/country/country.dart';
import 'package:sona/utils/dialog/crop_image.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/global/global.dart' as global;
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/picker/interest.dart';

import '../../core/persona/widgets/sona_message.dart';
import '../../utils/picker/gender.dart';
import '../models/gender.dart';
import 'confirm_photo.dart';

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
  String? _country;
  late SonaLocale _locale;
  Set<String> _interests = <String>{};

  bool get _nameValidate =>
      _name != null && _name!.isNotEmpty && _name!.length < 32;
  bool get _validate =>
      _nameValidate &&
      _gender != null &&
      _birthday != null &&
      _avatar != null && _avatar!.isNotEmpty;

  @override
  void initState() {
    _initActions();
    _locale = findMatchedSonaLocale(Platform.localeName);
    super.initState();
  }

  void _initActions() async {
    final profile = global.profile;
    _actions = [
      FieldAcquireAction(
          field: null,
          textBuilder: () => '\n\nHi\n\nI’m SONA, a ninja got your back\n\nI’ll help you find better matches and chat\n\nLet\’s add your information.',
          highlights: ['SONA'],
          action: null
      ),
      if (profile?.name == null) FieldAcquireAction(
          field: 'name',
          textBuilder: () => '\n\nFirst, what\'s your name?',
          highlights: [],
          action: _getName
      ),
      if (profile?.birthday == null) FieldAcquireAction(
          field: 'birthday',
          textBuilder: () => '\n\nPlz choose your birthday.',
          highlights: [],
          action: _getBirthday
      ),
      if (profile?.gender == null) FieldAcquireAction(
          field: 'gender',
          textBuilder: () => '\n\nPlz choose your gender.',
          highlights: [],
          action: _getGender
      ),
      if (profile?.avatar == null) FieldAcquireAction(
          field: 'avatar',
          textBuilder: () => '\n\nPick a photo represents you',
          highlights: [],
          action: _getAPhotoAndUpload
      ),
      if (profile?.locale == null) FieldAcquireAction(
          field: 'locale',
          textBuilder: () => '\n\nsth. more',
          highlights: [],
          action: _selectLocale
      ),
    ];
    countryMapList = jsonDecode(await rootBundle.loadString('assets/i18n/countries.json'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _actions
              .map((action) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 50),
                    child: Typwriter(
                        textBuilder: action.textBuilder,
                        highlights: action.highlights,
                        duration: const Duration(milliseconds: 40),
                        onDone: () async {
                          if (action.action != null) {
                            action.value = await action.action!();
                            action.value ??= await action.action!();
                            if (action.value == null) return;
                          }
                          if (action.field == 'locale') {
                            if (_validate && mounted) {
                              ref.read(myProfileProvider.notifier).updateField(
                                name: _name,
                                birthday: _birthday,
                                gender: _gender,
                                avatar: _avatar,
                                interests: _interests,
                                country: _country,
                                locale: _locale
                              );
                              global.SonaAnalytics.log('reg_confirm');
                              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                            } else {
                              Fluttertoast.showToast(msg: 'Invalid info');
                            }
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
    final value = await showNameTextField(context: context);
    if (value == null || value.isEmpty) {
      return _getName();
    } else {
      global.SonaAnalytics.log('reg_name');
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
      if (value.toAge() < 17 && mounted) {
        await showInfo(context: context, content: 'You must be 17+ to register.\n'
            'You entered an underage birthdate so you cannot complete registration.');
        exit(0);
      }
      global.SonaAnalytics.log('reg_birthday');
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
      global.SonaAnalytics.log('reg_gender');
      _actions.firstWhere((action) => action.field == 'gender')
        ..value = value
        ..done = true;
      _gender = value;
      return value;
    }
  }

  Future<String> _getAPhotoAndUpload() async {
    try {
      final source = await showRadioFieldDialog(
          context: context,
          options: {
            'Choose a photo': ImageSource.gallery,
            'Take a photo': ImageSource.camera
          },
          dismissible: false
      );
      if (source == null) throw Exception('No source');
      final picker = ImagePicker();
      final file = await picker.pickImage(source: source);
      if (file == null) throw Exception('No file');
      if (file.name.toLowerCase().endsWith('.gif')) {
        Fluttertoast.showToast(msg: 'GIF is not allowed');
        throw Error();
      }
      Uint8List? bytes = await file.readAsBytes();
      bytes = await cropImage(bytes);
      if (bytes == null) {
        throw Exception('No file');
      }
      final value = await _confirmPhoto(bytes);
      if (value == null) {
        return _getAPhotoAndUpload();
      }
      global.SonaAnalytics.log('reg_avatar_${source.name}');
      _actions.firstWhere((action) => action.field == 'avatar')
        ..value = value
        ..done = true;
      _avatar = value;
      return value;
    } catch (e) {
      return _getAPhotoAndUpload();
    }
  }

  // Future<Position> _determineLocation() async {
  //   return determinePosition();
  // }

  Future<String?> _confirmPhoto(Uint8List bytes) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmPhotoScreen(bytes: bytes)));
  }

  Future<Set<String>> _chooseInterests() async {
    final value = await showInterestPicker(context: context);
    if (value == null) {
      return _chooseInterests();
    } else {
      _actions.firstWhere((action) => action.field == 'interests')
        ..value = value
        ..done = true;
      _interests = value;
      return value;
    }
  }

  Future<SonaLocale> _selectLocale() async {
    final options = <String, String>{};
    for (var l in supportedSonaLocales) {
      options.addAll({l.displayName: l.locale.toLanguageTag()});
    }
    final value = await showRadioFieldDialog<String>(
      context: context,
      options: options,
      initialValue: _locale.locale.toLanguageTag(),
      dismissible: false
    );
    if (value == null) {
      return _selectLocale();
    } else {
      global.SonaAnalytics.log('reg_locale');
      _actions.firstWhere((action) => action.field == 'locale')
        ..value = value
        ..done = true;
      _country = 'CN';
      return findMatchedSonaLocale(value);
    }
  }
}

class FieldAcquireAction<T> {
  FieldAcquireAction({
    required this.field,
    required this.textBuilder,
    required this.highlights,
    required this.action
  });
  final String? field;
  String Function() textBuilder;
  List<String> highlights;
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
    try {
      final resp = await fetchAvailableInterests();
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
