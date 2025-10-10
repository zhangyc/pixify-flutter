import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

/// 位置选择器工具类
class LocationPickerUtil {
  /// 显示位置选择器
  static Future<String?> showLocationPicker({
    required BuildContext context,
    String? initialLocation,
  }) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return LocationPickerDialog(initialLocation: initialLocation);
      },
    );
  }
}

/// 位置选择对话框
class LocationPickerDialog extends StatefulWidget {
  final String? initialLocation;

  const LocationPickerDialog({
    super.key,
    this.initialLocation,
  });

  @override
  State<LocationPickerDialog> createState() => _LocationPickerDialogState();
}

class _LocationPickerDialogState extends State<LocationPickerDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialLocation ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).selectBirthPlace),
      content: SizedBox(
        width: double.maxFinite,
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            // hintText: S.of(context).enterBirthPlace,
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          maxLines: 1,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).buttonCancel),
        ),
        TextButton(
          onPressed: () {
            final location = _controller.text.trim();
            if (location.isNotEmpty) {
              Navigator.of(context).pop(location);
            }
          },
          child: Text(S.of(context).buttonConfirm),
        ),
      ],
    );
  }
}
