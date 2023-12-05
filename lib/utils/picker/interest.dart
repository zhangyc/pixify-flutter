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
    backgroundColor: Colors.white,
    barrierColor: Colors.white.withOpacity(0.66),
    isScrollControlled: true,
    builder: (context) {
      Set<String>? _selected;

      return ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.66
          ),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom
          ),
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            shadows: [
              BoxShadow(
                color: Color(0xFF2C2C2C),
                blurRadius: 0,
                offset: Offset(0, -8),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(asyncInterestsProvider).when(
                      data: (interests) => Interests(
                        availableValue: interests,
                        initialValue: ref.read(myProfileProvider)!.interests.map((hb) => hb.code).toSet(),
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
                            child: CircularProgressIndicator(color: Color(0xffE980F1),)),
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
              FilledButton(
                child: Text('Save'),
                onPressed: () => Navigator.pop(context, _selected)
              )
            ],
          ),
        ),
      );
    },
  );
}
