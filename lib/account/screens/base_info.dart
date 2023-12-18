import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/picker/gender.dart';

import '../../generated/l10n.dart';
import 'avatar.dart';

class BaseInfoScreen extends StatefulWidget {
  const BaseInfoScreen({
    super.key,
    required this.country
  });
  final SonaCountry country;

  @override
  State<StatefulWidget> createState() => _BaseInfoScreenState();
}

class _BaseInfoScreenState extends State<BaseInfoScreen> {

  final _formKey = GlobalKey<FormState>(debugLabel: 'base_info');
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  DateTime? _birthday;
  Gender? _gender;

  bool get _disabled => _nameController.text.trim().isEmpty || _gender == null || _birthday == null;

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
      backgroundColor: Colors.white,
      extendBody: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: MediaQuery.of(context).viewPadding.top + 16,
                bottom: 160
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      S.current.userInfoPageTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(S.current.userNameInputLabel, style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).primaryColor
                          ),
                          borderRadius: BorderRadius.circular(12),
                          gapPadding: 8
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).primaryColor
                          ),
                          borderRadius: BorderRadius.circular(12),
                          gapPadding: 8
                      ),
                      hintText: S.current.userInfoPageNamePlaceholder
                      // hintStyle: TextStyle(color: Color(0xFFE9C6EE))
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    validator: (String? text) {
                      if (text == null || text.isEmpty) return 'Name can not be empty';
                      final len = utf8.encode(text).length;
                      if (len < 3) {
                        return 'At least 3 characters';
                      } else if (len > 32) {
                        return 'Can not over 32 characters';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onTapOutside: (_) {
                      _nameFocusNode.unfocus();
                    }
                  ),
                  SizedBox(height: 16,),
                  Text(S.current.userBirthdayInputLabel, style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 8),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      final value = await showBirthdayPicker(
                        context: context,
                        initialDate: DateTime(2000, 12, 31),
                        dismissible: _birthday != null
                      );
                      if (value != null) {
                        setState(() {
                          _birthday = value;
                        });
                      }
                    },
                    child: Container(
                      height: 64,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context).primaryColor
                          ),
                          borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_birthday != null) Text(
                            _birthday!.toBirthdayString(),
                            style: Theme.of(context).textTheme.bodyMedium
                          ) else Text(
                            S.current.choosePlaceholder,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).hintColor
                            ),
                          ),
                          Icon(Icons.date_range)
                        ],
                      )
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(S.current.userGenderInputLabel, style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 8),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      final value = await showGenderPicker(
                        context: context,
                        initialValue: _gender,
                        dismissible: _gender != null
                      );
                      if (value != null) {
                        setState(() {
                          _gender = value;
                        });
                      }
                    },
                    child: Container(
                        height: 64,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context).primaryColor
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_gender != null) Text(
                                _gender!.displayName,
                                style: Theme.of(context).textTheme.bodyMedium
                            ) else Text(
                              S.current.choosePlaceholder,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).hintColor
                              ),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FilledButton(
          child: Text(S.current.buttonNext),
          onPressed: _disabled ? null : _next,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _next() {
    if (_disabled) return;
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => AvatarScreen(
          name: _nameController.text.trim(),
          birthday: _birthday!,
          gender: _gender!,
          country: widget.country
        ))
    );
  }
}