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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                    'Choose Hobbies\nFor\nBetter Matches',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white
                    )
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
                  Text(
                      '${_selected.length}/10',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final interest in widget.availableValue)
                FittedBox(
                  child: GestureDetector(
                    onTap: () => _toggleInterest(interest),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: _selected.contains(interest) ? Theme.of(context).primaryColor : Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Text(
                        interest,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _selected.contains(interest) ? Colors.white : Colors.black
                        ),
                      ),
                    ),
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