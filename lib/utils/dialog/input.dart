import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sona/common/widgets/button/option.dart';

import '../../common/widgets/button/colored.dart';

Future<bool?> showInfo(
    {required BuildContext context,
    String? title,
    String content = '',
    String buttonText = 'Sure'}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    )),
    builder: (BuildContext context) {
      return SafeArea(
        top: false,
        child: Container(
//          padding: EdgeInsets.all(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                width: 30,
                height: 3,
                color: Colors.black26,
              ),
              SizedBox(height: 25),
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
                      Text(content,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2),
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

Future<bool?> showConfirm(
    {required BuildContext context,
    String? title = 'Are you sure',
    String confirmText = 'Sure',
    String cancelText = 'No',
    required String content}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    )),
    builder: (BuildContext context) {
      return SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              width: 30,
              height: 3,
              color: Colors.black26,
            ),
            SizedBox(height: 24),
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
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(content,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ColoredButton(
                            color: Colors.white,
                            text: cancelText,
                            onTap: () => Navigator.of(context).pop(false)),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: ColoredButton(
                            color: Color(0xFFE2E2F6),
                            text: confirmText,
                            onTap: () => Navigator.of(context).pop(true)),
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

Future<String?> showSingleLineTextField(
    {required BuildContext context,
    required String? title,
    String? tip,
    String? hintText,
    keyboardType = TextInputType.text,
    int maxLength = 64}) {
  final controller = TextEditingController();
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.black26,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    )),
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              width: 30,
              height: 3,
              color: Color(0xFF888888),
            ),
            SizedBox(height: 25),
            Visibility(
              visible: title != null && title.isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18)),
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
                          style: Theme.of(context).textTheme.caption),
                    ),
                  ),
                  TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    keyboardType: keyboardType,
                    autofocus: true,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ColoredButton(
                            color: Colors.white,
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
            SizedBox(height: 40)
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
  Widget? hint,
  int? maxLength,
  String saveText = 'Save',
  String cancelText = 'Cancel',
  int saveFlex = 1,
  int cancelFlex = 1
}) {
  final children = <Widget>[];
  children.addAll([
    const SizedBox(height: 10),
    Container(
      width: 30,
      height: 3,
      color: Colors.black12,
    ),
    const SizedBox(height: 24)
  ]);
  if (title != null) {
    children.add(Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18)
    ));
  }
  children.add(Container(
    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(4)
    ),
    child: TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Color(0xFFF1F1F1),
          alignLabelWithHint: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          contentPadding: EdgeInsets.zero
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 7,
      minLines: 7,
      maxLength: maxLength,
      autofocus: true,
    ),
  ));
  if (hint != null) children.add(hint);
  children.add(const SizedBox(height: 10));
  children.add(Row(
    children: [
      const SizedBox(width: 40),
      Expanded(
        flex: cancelFlex,
        child: ColoredButton(
            color: Colors.white,
            text: cancelText,
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: saveFlex,
        child: ColoredButton(
            text: saveText,
            onTap: () {
              if (controller.text.isNotEmpty) {
                Navigator.pop(context, controller.text);
              }
            }),
      ),
      const SizedBox(width: 40)
    ],
  ));
  children.add(const SizedBox(height: 20));

  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    )),
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
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
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    )),
    clipBehavior: Clip.antiAlias,
    isDismissible: dismissible,
    builder: (BuildContext context) {
      final itemCount = dismissible ? options.length + 1 : options.length;

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: title != null && title.isNotEmpty,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18)),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (index == options.length) {
                  return OptionButton(
                    onTap: () => Navigator.pop(context, null),
                    color: Colors.transparent,
                    text: 'Cancel',
                    fontColor: Theme.of(context).colorScheme.error,
                  );
                }

                final key = options.keys.toList(growable: false)[index];
                final value = options[key];
                return OptionButton(
                    onTap: () => Navigator.pop(context, value),
                    color: initialValue == value
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Colors.transparent,
                    text: key);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 1, indent: 0);
              },
              itemCount: itemCount,
            ),
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
      height: 208,
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
            height: 108,
            child: CupertinoDatePicker(
                initialDateTime: initialDate,
                mode: CupertinoDatePickerMode.date,
                showDayOfWeek: true,
                onDateTimeChanged: (DateTime newDate) {
                  _birthday = newDate;
                },
                itemExtent: 40),
          ),
          ColoredButton(
              text: 'Confirm',
              onTap: () {
                Navigator.pop(context, _birthday);
              })
        ],
      ),
    ),
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
