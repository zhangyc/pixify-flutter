import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/common/widgets/image/upload_field.dart';

import '../../common/services/report.dart';
import '../../common/widgets/button/colored.dart';
import '../../generated/l10n.dart';
import 'input.dart';

Future<bool?> showReport(BuildContext context, int userId) async {
  final reason = await _showReportReason(context);
  if (reason == null) return null;
  if (context.mounted) return _showReportForm(context, userId, reason);
  return null;
}

Future<int?> _showReportReason(BuildContext context) async {
  return showActionButtons<int>(
      context: context,
      options: {
        S.of(context).reportOptionGore: 1,
        S.of(context).reportOptionPornography: 2,
        S.of(context).reportOptionScam: 3,
        S.of(context).reportOptionPersonalAttack: 4,
        S.of(context).reportOptionOther: 5,
      }
  );
}

Future<bool?> _showReportForm(BuildContext context, int userId, int reason) {
  XFile? _file;
  final _controller = TextEditingController();
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
  children.addAll([
    Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        'Add a screenshot',
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
    const SizedBox(height: 10),
    Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        child: UploadField(width: 70, height: 114, onChange: (file) => _file = file)
    ),
    const SizedBox(height: 20),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _controller,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
            hintText: 'More details(optional)',
            fillColor: Color(0xFFF1F1F1),
            alignLabelWithHint: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide()
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4)
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        minLines: 1,
        maxLength: 256,
      ),
    )
  ]);

  children.add(const SizedBox(height: 20));
  children.add(Row(
    children: [
      const SizedBox(width: 40),
      Expanded(
        flex: 1,
        child: ColoredButton(
            color: Colors.white,
            text: 'Cancel',
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: 1,
        child: ColoredButton(
            text: 'Submit',
            loadingWhenAsyncAction: true,
            onTap: () async {
              String? imageUrl;
              try {
                if (_file != null) {
                  imageUrl = await uploadImage(bytes: await _file!.readAsBytes());
                }
              } catch (e) {
                Fluttertoast.showToast(msg: 'Uploading image error, please try again later.');
                return;
              }

              try {
                final resp = await report(type: 1, id: userId, reason: reason, imageUrl: imageUrl, desc: _controller.text);
                if (resp.statusCode == 0) {
                  Fluttertoast.showToast(msg: 'We have received your report and will process it within 24 hours.');
                  if (context.mounted) Navigator.pop(context, true);
                }
              } catch (e) {
                Fluttertoast.showToast(msg: 'Network error, please try again later.');
              }
            }),
      ),
      const SizedBox(width: 40)
    ],
  ));
  children.add(const SizedBox(height: 20));

  return showModalBottomSheet<bool>(
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