import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/tag/hobby.dart';

import '../models/hobby.dart';

class Interests extends ConsumerStatefulWidget {
  const Interests({
    super.key,
    required this.availableValue,
    required this.initialValue,
    required this.onChange
  });
  final List<UserHobby> availableValue;
  final Set<String>? initialValue;
  final void Function(Set<String>) onChange;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InterestsState();
}

class _InterestsState extends ConsumerState<Interests> {

  static const maxCount = 10;
  late Set<String> _selected = widget.initialValue ?? {};

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Choose hobbies ${_selected.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: '/$maxCount',
                      style: Theme.of(context).textTheme.bodySmall
                    )
                  ]
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.close, size: 28)
                    )
                  ),
                  SizedBox(height: 8),
                ],
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  for (final hobby in widget.availableValue)
                    HobbyTag<String>(
                        displayName: hobby.displayName,
                        value: hobby.code,
                        selected: _selected.contains(hobby.code),
                        onSelect: (hb) => _toggleInterest(hb)
                    )
                ],
              ),
            ),
          ),
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