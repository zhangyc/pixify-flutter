import 'package:flutter/material.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/common/widgets/image/icon.dart';

class GenderPickerDialog extends StatelessWidget {
  const GenderPickerDialog(
      {super.key,
      required this.initialValue,
      required this.dismissible,
      this.title,
      this.content,
      required this.options});
  final Gender initialValue;
  final bool dismissible;
  final String? title;
  final String? content;
  final Map<String, Gender> options;
  @override
  Widget build(BuildContext context) {
    final keys = options.keys.toList(growable: false);

    return Container(
      margin: EdgeInsets.only(top: 4),
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 12),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFF2C2C2C),
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (title != null)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Text(title!,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    if (content != null)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Text(content!,
                            style: Theme.of(context).textTheme.labelMedium),
                      )
                  ],
                ),
              ),
              SIconButton.outlined(
                  backgroundColor: Colors.white,
                  icon: SonaIcons.close, onTap: () => Navigator.pop(context))
            ],
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) => RadioListTile(
                  value: options[keys[index]],
                  groupValue: initialValue,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) => Navigator.pop(context, value),
                  activeColor: Theme.of(context).primaryColor,
                  selectedTileColor: Theme.of(context).primaryColor,
                  tileColor: Theme.of(context).primaryColor,
                  contentPadding:
                      EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 0),
                  title: Text(keys[index])),
              itemCount: keys.length,
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
    ;
  }
}
