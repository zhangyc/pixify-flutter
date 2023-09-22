import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/interests.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/interests.dart';

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
    useSafeArea: true,
    builder: (context) {
      return ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Container(
                  width: 30,
                  height: 3,
                  color: Color(0xFF888888),
                ),
                SizedBox(height: 25),
                Visibility(
                  visible: title != null && title.isNotEmpty,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(title ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(asyncInterestsProvider).when(
                      data: (interests) => Interests(availableValue: interests, initialValue: ref.read(asyncMyProfileProvider).value!.interests.toSet()),
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
              ],
            ),
          ),
      );
    },
  );
}
