import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/interests.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/interests.dart';

import '../../common/widgets/button/colored.dart';

Future<Set<String>?> showInterestPicker({
  required BuildContext context,
  Set<String>? initialValue = const {},
  int? maxAmount = 10,
  int? minAmount = 3,
  String? title,
  bool dismissible = true,
}) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black54,
    builder: (context) {
      Set<String>? _selected;

      return ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
            bottom: MediaQuery.of(context).viewPadding.bottom
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Consumer(
                      builder: (context, ref, child) {
                        return ref.watch(asyncInterestsProvider).when(
                          data: (interests) => Interests(
                            availableValue: interests,
                            initialValue: ref.read(myProfileProvider)!.interests.toSet(),
                            onChange: (Set<String> selected) {
                              _selected = selected;
                            }
                          ),
                          loading: () => Container(
                            color: Colors.white54,
                            alignment: Alignment.center,
                            child: const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(color: Colors.transparent,)),
                          ),
                          error: (err, stack) => GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => ref.refresh(asyncInterestsProvider.notifier),
                            child: Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: const Text(
                                  'Cannot connect to server, tap to retry',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.none
                                  )
                              ),
                            ),
                          )
                        );
                      }
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.transparent,
                  child: Row(
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
                            onTap: () => Navigator.pop(context, _selected)
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
      );
    },
  );
}
