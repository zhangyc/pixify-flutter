import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/common/widgets/button/next.dart';
import 'package:sona/common/widgets/button/option.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/utils/locale/locale.dart';

import '../../common/widgets/button/colored.dart';
import '../../generated/l10n.dart';

Future<bool?> showInfo({
  required BuildContext context,
  String? title,
  String content = '',
  String buttonText = 'Sure'
}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )
    ),
    builder: (BuildContext context) {
      return SafeArea(
        top: false,
        child: Container(
//          padding: EdgeInsets.all(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 30,
                height: 3,
                color: Colors.black26,
              ),
              const SizedBox(height: 25),
              Visibility(
                visible: title != null,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(title ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 40),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          content,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodySmall
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(flex: 1, child: Container()),
                          Expanded(
                            flex: 2,
                            child: ColoredButton(
                                text: buttonText,
                                onTap: () => Navigator.pop(context, true)),
                          ),
                          Flexible(flex: 1, child: Container())
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool?> showConfirm({
  required BuildContext context,
  String? title = 'Are you sure',
  String confirmText = 'Sure',
  String cancelText = 'No',
  bool danger = false,
  Duration? confirmDelay,
  required String content
}) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.white.withOpacity(0.6),
    // backgroundColor: Colors.white,
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.only(
    //     topLeft: Radius.circular(30),
    //     topRight: Radius.circular(30),
    //   )
    // ),
    builder: (BuildContext context) {
      return SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Color(0xFF2C2C2C)),
                  borderRadius: BorderRadius.circular(24),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0xFF2C2C2C),
                    blurRadius: 0,
                    offset: Offset(0, -4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: title != null,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          content,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodySmall
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ColoredButton(
                                  color: Colors.white,
                                  fontColor: Theme.of(context).primaryColor,
                                  text: cancelText,
                                  onTap: () => Navigator.of(context).pop(false)),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 1,
                              child: ColoredButton(
                                  text: confirmText,
                                  color: danger ? Color(0xFFEA4710) : Theme.of(context).primaryColor,
                                  confirmDelay: confirmDelay,
                                  onTap: () => Navigator.of(context).pop(true)
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<String?> showNameTextField({
  required BuildContext context,
}) {
  final controller = TextEditingController();
  return showModalBottomSheet<String>(
    context: context,
    elevation: 0,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    isDismissible: false,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 40, left: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF515B24)
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  hintText: 'Your Name',
                ),
                maxLength: 24,
                buildCounter: (BuildContext context, {required int currentLength, required bool isFocused, required int? maxLength}) => null,
                autofocus: true,
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                child: NextButton(
                  size: ButtonSize.large,
                  loadingWhenAsyncAction: true,
                  onTap: () => Navigator.pop(context, controller.text.trim()),
                ),
              ),
            ),
            SizedBox(height: 40)
          ],
        )
      );
    },
  );
}

Future<String?> showSingleLineTextField({
  required BuildContext context,
  required String? title,
  String? tip,
  String? hintText,
  keyboardType = TextInputType.text,
  int maxLength = 64
}) {
  final controller = TextEditingController();
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    barrierColor: Colors.white.withOpacity(0.9),
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    )),
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            // side: BorderSide(width: 2, color: Color(0xFF2C2C2C)),
            borderRadius: BorderRadius.circular(24),
          ),
          shadows: [
            BoxShadow(
              color: Color(0xFF2C2C2C),
              blurRadius: 0,
              offset: Offset(0, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: title != null && title.isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                    title ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium
                )
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: tip != null && tip.isNotEmpty,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 0, bottom: 12),
                      child: Text(tip ?? '',
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ),
                  TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    keyboardType: keyboardType,
                    autofocus: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ColoredButton(
                            color: Colors.white,
                            fontColor: Theme.of(context).primaryColor,
                            text: 'Cancel',
                            onTap: () => Navigator.pop(context)),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: ColoredButton(
                            text: 'Confirm',
                            onTap: () {
                              Navigator.pop(context, controller.text.trim());
                            }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<String?> showTextFieldDialog({
  required BuildContext context,
  required TextEditingController controller,
  String? title,
  String? hintText,
  int? maxLength,
  String saveText = 'Save',
}) {
  final children = <Widget>[];
  children.add(Row(
    children: [
      if (title != null) Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
      SIconButton(
          icon: SonaIcons.close,
          backgroundColor: Colors.transparent,
          borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
          onTap: () => Navigator.pop(context)
      )
    ],
  ));
  children.add(Container(
    margin: EdgeInsets.only(top: 16),
    decoration: BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      borderRadius: BorderRadius.circular(20)
    ),
    child: TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Color(0xFFF1F1F1),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none
        ),
        focusColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.all(16)
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 5,
      maxLength: maxLength,
      autofocus: true,
    ),
  ));
  children.add(const SizedBox(height: 10));
  children.add(ColoredButton(
    size: ColoredButtonSize.large,
    text: saveText,
    onTap: () {
      if (controller.text.isNotEmpty) {
        Navigator.pop(context, controller.text);
      }
    },
  ));

  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )
    ),
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            // side: BorderSide(width: 2, color: Color(0xFF2C2C2C)),
            borderRadius: BorderRadius.circular(24),
          ),
          shadows: [
            BoxShadow(
              color: Color(0xFF2C2C2C),
              blurRadius: 0,
              offset: Offset(0, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children
        ),
      );
    },
  );
}

Future<T?> showRadioFieldDialog<T>({
  required BuildContext context,
  T? initialValue,
  required Map<String, T> options,
  String? title,
  bool dismissible = true
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    elevation: 0,
    useSafeArea: true,
    clipBehavior: Clip.antiAlias,
    isDismissible: dismissible,
    builder: (BuildContext context) {
      final keys = options.keys.toList(growable: false);
      return Container(
        margin: EdgeInsets.all(16),
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: title != null && title.isNotEmpty,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(title ?? '', style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF2C2C2C),
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0xFF2C2C2C),
                    blurRadius: 0,
                    offset: Offset(0, -4),
                    spreadRadius: 0,
                  )
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => OptionButton(
                    onTap: () => Navigator.pop(context, options[keys[index]]),
                    color: initialValue == options[keys[index]]
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Colors.transparent,
                    text: keys[index]
                ),
                itemCount: keys.length,
              ),
            ),
            SizedBox(height: 12),
            if (dismissible) Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Color(0xFF2C2C2C)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: OptionButton(
                onTap: () => Navigator.pop(context, null),
                color: Colors.transparent,
                text: S.current.cancel,
              ),
            )
          ],
        ),
      );
    },
  );
}

Future<DateTime?> showBirthdayPicker({
  required BuildContext context,
  required DateTime initialDate,
  bool dismissible = true,
}) {
  DateTime _birthday = initialDate;
  return showCupertinoModalPopup<DateTime>(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) => Container(
      height: 338,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
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
            height: 188,
            child: CupertinoDatePicker(
              initialDateTime: initialDate,
              mode: CupertinoDatePickerMode.date,
              showDayOfWeek: true,
              maximumDate: DateTime.now().yearsAgo(18),
              onDateTimeChanged: (DateTime newDate) {
                _birthday = newDate;
              },
              itemExtent: 40
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: FilledButton(
                child: Text('Confirm'),
                onPressed: () {
                  Navigator.pop(context, _birthday);
                }),
          )
        ],
      ),
    ),
  );
}

Future<String?> showLocalePicker({
  required BuildContext context,
  String? initialValue,
  bool dismissible = true,
}) {
  final options = <String, String>{};
  for (var l in supportedSonaLocales) {
    options.addAll({l.displayName: l.locale.toLanguageTag()});
  }
  return showRadioFieldDialog<String>(
      context: context,
      options: options,
      title: 'Choose a Language',
      initialValue: initialValue,
      dismissible: dismissible
  );
}

Future openExternalWebsite(BuildContext context, String url) async {
  await showConfirm(
    context: context,
    title: 'Warning',
    content:
        '$url\n\nYou are opening an external website. Please guard against scams, etc.',
  ).then((confirm) {
    if (confirm == true) {
      Navigator.pushNamed(context, "WebPage.routeName",
          arguments: {'url': url});
    }
  });
}
