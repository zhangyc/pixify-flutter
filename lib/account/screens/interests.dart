import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/interests.dart';
import 'package:sona/common/widgets/button/colored.dart';

import '../providers/profile.dart';

class InterestsScreen extends ConsumerStatefulWidget {
  const InterestsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends ConsumerState<InterestsScreen> {

  late Set<String> _selected;

  @override
  void initState() {
    _selected = ref.read(asyncMyProfileProvider).value!.interests.toSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interests'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save', style: TextStyle(color: Colors.black))
          )
        ],
      ),
      body: ref.watch(asyncInterestsProvider).when(
        data: (interests) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final interest in interests)
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
        ),
        loading: () => Container(
          color: Colors.white54,
          alignment: Alignment.center,
          child: const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator()),
        ),
        error: (err, stack) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref
              .refresh(asyncInterestsProvider),
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: const Text(
                'Cannot connect to server, tap to retry',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.none)),
          ),
        )
      )
    );
  }

  void _toggleInterest(String i) async {
    if (_selected.contains(i)) {
      _selected.remove(i);
    } else {
      _selected.add(i);
    }
    setState(() {

    });
  }

  void _save() {
    final interests = ref.read(asyncMyProfileProvider.notifier).updateInfo(interests: _selected);
  }
}