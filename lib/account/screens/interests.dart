import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/interests.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/tag/hobby.dart';

import '../../common/widgets/image/icon.dart';
import '../models/hobby.dart';

class HobbiesSelector extends ConsumerStatefulWidget {
  const HobbiesSelector({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HobbiesSelectorState();
}

class _HobbiesSelectorState extends ConsumerState<HobbiesSelector> {
  static const maxCount = 10;
  late Set<String> _selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _selected = ref.read(myProfileProvider)!.interests.map((hobby) => hobby.code).toSet();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SonaIcon(icon: SonaIcons.back),
        ),
        title: Text('Choose Hobbies'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Text.rich(
              TextSpan(
                  text: '${_selected.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                        text: '/$maxCount',
                        style: Theme.of(context).textTheme.bodySmall
                    )
                  ]
              ),
            ),
          )
        ],
      ),
      body: ref.watch(asyncInterestsProvider).when(
        data: (data) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 120),
            child: Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                for (final hobby in data)
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
        loading: () => Container(
          color: Colors.white54,
          alignment: Alignment.center,
          child: const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator()
          ),
        ),
        error: (err, stack) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref.read(asyncInterestsProvider.notifier).refresh(),
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: const Text(
                'Cannot connect to server\ntap to retry',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.none
                )
            ),
          ),
        )
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ColoredButton(
          size: ColoredButtonSize.large,
          text: 'Save',
          loadingWhenAsyncAction: true,
          onTap: () => ref.read(myProfileProvider.notifier).updateField(interests: _selected).then((_) => Navigator.pop(context)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
}