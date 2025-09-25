import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui';

import 'package:sona/utils/toast/flutter_toast.dart';
import 'package:sona/utils/uuid.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class DmDialogContent extends StatefulWidget {
  const DmDialogContent({
    super.key,
    required this.next,
    required this.info,
  });
  final VoidCallback next;
  final MatchUserInfo info;
  @override
  State<DmDialogContent> createState() => _DmDialogContentState();
}

class _DmDialogContentState extends State<DmDialogContent> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            controller.addListener(() {
              setState(() {});
            });
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).dm),
                        GestureDetector(
                          child: Image.asset(
                            Assets.iconsSkip,
                            width: 40,
                            height: 40,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Text(
                        S.of(context).oneLineToWin,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            // onTapOutside: (cv){
                            //   FocusManager.instance.primaryFocus?.unfocus();
                            // },
                            controller: controller,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  160), // Maximum length of 10 characters
                            ],
                            decoration: InputDecoration(
                                hintText: S.of(context).wannaHollaAt,
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(24)),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16)),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        controller.text.isNotEmpty
                            ? GestureDetector(
                                child: Image.asset(
                                  Assets.iconsSend,
                                  width: 56,
                                  height: 56,
                                ),
                                onTap: () async {
                                  if (controller.text.isEmpty) {
                                    return;
                                  }
                                  if (canArrow) {
                                    MatchApi.customSend(
                                        widget.info.id, controller.text);
                                    SonaAnalytics.log(
                                        MatchEvent.match_arrow_send.name);

                                    widget.next.call();
                                    Navigator.pop(context);
                                  } else {
                                    bool isMember =
                                        ref.read(myProfileProvider)?.isMember ??
                                            false;
                                    if (isMember) {
                                      Fluttertoast.showToast(
                                          msg: 'Arrow on cool down this week');
                                    } else {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (c) {
                                        return SubscribePage(
                                          fromTag: FromTag.duo_snap,
                                        );
                                      }));
                                    }
                                  }
                                },
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
