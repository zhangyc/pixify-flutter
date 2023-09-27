import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/button/colored.dart';

class Interests extends ConsumerStatefulWidget {
  const Interests({
    super.key,
    required this.availableValue,
    required this.initialValue,
    required this.onChange
  });
  final List<String> availableValue;
  final Set<String>? initialValue;
  final void Function(Set<String>) onChange;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InterestsState();
}

class _InterestsState extends ConsumerState<Interests> {

  late Set<String> _selected = widget.initialValue ?? {};

  @override
  Widget build(BuildContext context) {
    return Column(
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
          SizedBox(height: 20,)
        ],
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
    widget.onChange(_selected);
    setState(() {});
  }
}