import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sona/account/dialogs/account_dialogs.dart';
import 'package:sona/account/event/account_event.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/astro/widgets/astro_preview.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';

import '../../core/match/util/local_data.dart';
import '../../generated/l10n.dart';
import 'avatar.dart';

class BaseInfoScreen extends ConsumerStatefulWidget {
  const BaseInfoScreen({super.key, this.name, required this.country});
  final String? name;
  final SonaCountry country;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseInfoScreenState();
}

class _BaseInfoScreenState extends ConsumerState<BaseInfoScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'base_info');
  late final _nameController = TextEditingController(text: widget.name);
  final _nameFocusNode = FocusNode();
  DateTime? _birthday = DateTime(2000, 12, 31);
  Gender? _gender;
  String? _birthCity;

  bool get _disabled =>
      _nameController.text.trim().isEmpty ||
      _gender == null ||
      _birthday == null;

  @override
  void initState() {
    _nameController.addListener(_nameListener);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.removeListener(_nameListener);
    super.dispose();
  }

  void _nameListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
          top: false,
          child: Stack(
            children: [
              // // 背景星盘
              // Positioned(
              //   top: MediaQuery.of(context).viewPadding.top + 60,
              //   right: -50,
              //   child: Opacity(
              //     opacity: 0.15,
              //     child: AstroPreview(
              //       birthday: _birthday,
              //       country: widget.country,
              //       birthCity: _birthCity,
              //       isBackground: true,
              //     ),
              //   ),
              // ),

              // 主要内容
              SingleChildScrollView(
                reverse: true,
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: MediaQuery.of(context).viewPadding.top + 20,
                    bottom: 160),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 标题区域
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Text(
                          S.current.userInfoPageTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 姓名输入区域
                      _buildInputSection(
                        context,
                        label: S.current.userNameInputLabel,
                        child: TextFormField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color(0xFF1A1A1F)
                                  : const Color(0xFFF8F9FA),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 8),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 8),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 8),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 8),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                  borderRadius: BorderRadius.circular(20),
                                  gapPadding: 8),
                              hintText: S.current.userInfoPageNamePlaceholder,
                              hintStyle: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 16,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                            validator: (String? text) {
                              if (text == null || text.isEmpty)
                                return 'Name can not be empty';
                              final len = utf8.encode(text).length;
                              if (len < 3) {
                                return 'At least 3 characters';
                              } else if (len > 32) {
                                return 'Can not over 32 characters';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onTapOutside: (_) {
                              _nameFocusNode.unfocus();
                            }),
                      ),

                      const SizedBox(height: 16),

                      // 生日选择区域
                      _buildInputSection(
                        context,
                        label: S.current.userBirthdayInputLabel,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            final value =
                                await AccountDialogs.showBirthdayPicker(context,
                                    initialDate: DateTime(2000, 12, 31),
                                    dismissible: _birthday != null);
                            if (value != null) {
                              setState(() {
                                _birthday = value;
                              });
                              SonaAnalytics.log('reg_birthday');
                            }
                          },
                          child: Container(
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFF1A1A1F)
                                    : const Color(0xFFF8F9FA),
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (_birthday != null)
                                    Text(_birthday!.toBirthdayString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ))
                                  else
                                    Text(
                                      S.current.choosePlaceholder,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 20,
                                  )
                                ],
                              )),
                        ),
                      ),

                      // const SizedBox(height: 16),

                      // // 出生城市选择区域
                      // _buildInputSection(
                      //   context,
                      //   label: '出生城市',
                      //   child: GestureDetector(
                      //     behavior: HitTestBehavior.translucent,
                      //     onTap: () async {
                      //       final value = await _showCityPicker(context);
                      //       if (value != null) {
                      //         setState(() {
                      //           _birthCity = value;
                      //         });
                      //         SonaAnalytics.log('reg_birth_city');
                      //       }
                      //     },
                      //     child: Container(
                      //         height: 48,
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 16),
                      //         decoration: BoxDecoration(
                      //           color: Theme.of(context).brightness ==
                      //                   Brightness.dark
                      //               ? const Color(0xFF1A1A1F)
                      //               : const Color(0xFFF8F9FA),
                      //           border: Border.all(
                      //               width: 2,
                      //               color: Theme.of(context)
                      //                   .primaryColor
                      //                   .withOpacity(0.3)),
                      //           borderRadius: BorderRadius.circular(16),
                      //         ),
                      //         alignment: Alignment.center,
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             if (_birthCity != null)
                      //               Text(_birthCity!,
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyMedium
                      //                       ?.copyWith(
                      //                         fontSize: 16,
                      //                         fontWeight: FontWeight.w500,
                      //                       ))
                      //             else
                      //               Text(
                      //                 '请选择出生城市',
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyMedium
                      //                     ?.copyWith(
                      //                       color: Theme.of(context).hintColor,
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.w400,
                      //                     ),
                      //               ),
                      //             Icon(
                      //               Icons.location_city_outlined,
                      //               color: Theme.of(context).primaryColor,
                      //               size: 20,
                      //             )
                      //           ],
                      //         )),
                      //   ),
                      // ),

                      const SizedBox(height: 16),

                      // 性别选择区域
                      _buildInputSection(
                        context,
                        label: S.current.userGenderInputLabel,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            final value = await AccountDialogs.showGenderPicker(
                                context,
                                initialValue: Gender.male,
                                dismissible: _gender != null);
                            if (value != null) {
                              setState(() {
                                _gender = value;
                              });
                              SonaAnalytics.log('reg_gender');
                            }
                          },
                          child: Container(
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFF1A1A1F)
                                    : const Color(0xFFF8F9FA),
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (_gender != null)
                                    Text(_gender!.displayName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ))
                                  else
                                    Text(
                                      S.current.choosePlaceholder,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Theme.of(context).primaryColor,
                                    size: 24,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FilledButton(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            S.current.buttonNext,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          onPressed: _disabled ? null : _next,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildInputSection(
    BuildContext context, {
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Future<String?> _showCityPicker(BuildContext context) async {
    final cities = [
      '北京市',
      '上海市',
      '广州市',
      '深圳市',
      '杭州市',
      '南京市',
      '武汉市',
      '成都市',
      '重庆市',
      '西安市',
      '天津市',
      '苏州市',
      '长沙市',
      '郑州市',
      '青岛市',
      '大连市',
      '宁波市',
      '厦门市',
      '福州市',
      '哈尔滨市',
      '济南市',
      '石家庄市',
      '长春市',
      '沈阳市',
      '太原市',
      '合肥市',
      '昆明市',
      '南宁市',
      '海口市',
      '贵阳市',
      '兰州市',
      '银川市',
      '西宁市',
      '乌鲁木齐市',
      '拉萨市',
      '呼和浩特市',
    ];

    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            // 拖拽指示器
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 20),

            // 标题
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '选择出生城市',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      size: 24,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 城市列表
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  final isSelected = _birthCity == city;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor.withOpacity(0.1)
                          : Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF1A1A1F)
                              : const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.2),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        city,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                            ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            )
                          : null,
                      onTap: () => Navigator.pop(context, city),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _next() async {
    EasyLoading.show();
    if (_disabled) return;
    final _language =
        findMatchedSonaLocale(Intl.canonicalizedLocale(Platform.localeName))
            .locale
            .toLanguageTag();

    /// 这里就进行注册，后续的步骤多余了，注册成功直接进入主页
    final result = await ref.read(myProfileProvider.notifier).updateFields(
        name: _nameController.text.trim(),
        birthday: _birthday,
        gender: _gender,
        locale: findMatchedSonaLocale(_language),
        countryCode: widget.country.code);
    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute<void>(
      //         builder: (_) => AvatarScreen(
      //             name: _nameController.text.trim(),
      //             birthday: _birthday!,
      //             gender: _gender!,
      //             country: widget.country)));
      SonaAnalytics.log(AccountEvent.reg_profile_next.name);
    }
    try {} catch (e) {
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }
}
