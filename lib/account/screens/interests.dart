import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/button/colored.dart';

class Interests extends ConsumerStatefulWidget {
  const Interests({
    super.key,
    required this.availableValue,
    required this.initialValue,
  });
  final List<String> availableValue;
  final Set<String>? initialValue;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InterestsState();
}

class _InterestsState extends ConsumerState<Interests> {

  late Set<String> _selected = widget.initialValue ?? {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select your interests (${_selected.length}/10)', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final interest in widget.availableValue)
                FittedBox(
                  child: ColoredButton(
                    size: ColoredButtonSize.small,
                    color: _selected.contains(interest) ? Theme.of(context).primaryColor : Colors.transparent,
                    fontColor: _selected.contains(interest) ? Colors.white : Colors.black,
                    borderColor: Colors.black12,
                    text: interest,
                    onTap: () => _toggleInterest(interest)
                  ),
                )
            ],
          ),
          SizedBox(height: 20),
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
                  onTap: _save
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _toggleInterest(String i) async {
    if (_selected.contains(i)) {
      _selected.remove(i);
    } else {
      if (_selected.length >= 10) {
        return;
      }
      _selected.add(i);
    }
    setState(() {});
  }

  void _save() {
    // final interests = ref.read(asyncMyProfileProvider.notifier).updateInfo(interests: _selected);
    Navigator.pop(context, _selected);
  }
}