import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sona/generated/l10n.dart';

import '../../../common/widgets/image/icon.dart';

class MultiLineTextFieldScreen extends StatefulWidget {
  const MultiLineTextFieldScreen(
      {super.key,
      this.initialValue,
      this.title,
      this.hint,
      this.hintText,
      this.maxLength,
      this.autofocus = true,
      this.validator,
      required this.onSave});
  final String? initialValue;
  final String? title;
  final String? hint;
  final String? hintText;
  final int? maxLength;
  final bool autofocus;
  final String? Function(String)? validator;
  final FutureOr Function(String) onSave;

  @override
  State<StatefulWidget> createState() => _MultiLineTextFieldScreenState();
}

class _MultiLineTextFieldScreenState extends State<MultiLineTextFieldScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SonaIcon(icon: SonaIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
          title: (widget.title != null) ? Text(widget.title!) : null,
          actions: [
            TextButton(
                onPressed: () {
                  final input = _controller.text.trim();
                  if (input.isNotEmpty && input != widget.initialValue) {
                    widget.onSave(input);
                  } else {
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size.zero)),
                child: Text(S.of(context).buttonSave))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.hint != null)
              Container(
                margin: EdgeInsets.all(16),
                child: Text(widget.hint!,
                    style: Theme.of(context).textTheme.labelMedium),
              ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                onTapOutside: (cv) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: _controller,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    fillColor: Color(0xFFF1F1F1),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusColor: Theme.of(context).primaryColor,
                    contentPadding: EdgeInsets.all(16)),
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                minLines: 7,
                maxLength: widget.maxLength,
                autofocus: true,
              ),
            ),
          ],
        )));
  }
}
