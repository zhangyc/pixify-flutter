import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui';

import 'package:sona/utils/toast/flutter_toast.dart';
import 'package:sona/utils/uuid.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../../core/diamond/services/diamond.dart';
import '../../../core/diamond/diamond_store_page.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';

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
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF6366F1), // 紫色
                                            Color(0xFF8B5CF6), // 深紫色
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF8B5CF6)
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // 发送图标
                                          Image.asset(
                                            Assets.iconsSend,
                                            width: 24,
                                            height: 24,
                                          ),
                                          // 钻石消耗提示 - 右上角小标签
                                          Positioned(
                                            top: 4,
                                            right: 4,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 1),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.diamond,
                                                    size: 8,
                                                    color:
                                                        const Color(0xFF8B5CF6),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    '50',
                                                    style: const TextStyle(
                                                      color: Color(0xFF8B5CF6),
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () async {
                                      if (controller.text.isEmpty) {
                                        return;
                                      }
                                      await EasyLoading.show();

                                      // 检查钻石余额
                                      const dmCost = 50; // DM发送需要50钻石
                                      try {
                                        final checkResult =
                                            await DiamondService.checkBalance(
                                          requiredDiamonds: dmCost,
                                        );

                                        await EasyLoading.dismiss();

                                        if (checkResult.isSuccess &&
                                            !checkResult.data["hasEnough"]) {
                                          // 钻石不足，跳转到钻石商店
                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              builder: (context) =>
                                                  const DiamondStorePage(),
                                            ),
                                          );
                                          return;
                                        }
                                      } catch (e) {
                                        await EasyLoading.dismiss();
                                        Fluttertoast.showToast(
                                            msg: '检查钻石余额失败: $e');
                                        return;
                                      }

                                      if (canArrow) {
                                        // 消费钻石
                                        try {
                                          final consumeResult =
                                              await DiamondService.consume(
                                            diamondCount: dmCost,
                                            remark: S.current.sendDmRemark,
                                          );

                                          if (!consumeResult.isSuccess) {
                                            await EasyLoading.dismiss();
                                            Fluttertoast.showToast(
                                                msg: S.current
                                                    .diamondConsumeFailed);
                                            return;
                                          }

                                          // 发送消息
                                          MatchApi.customSend(widget.info.id,
                                              controller.text, uuid.v4());
                                          SonaAnalytics.log(
                                              MatchEvent.match_arrow_send.name);

                                          widget.next.call();
                                          Navigator.pop(context);
                                        } catch (e) {
                                          await EasyLoading.dismiss();
                                          Fluttertoast.showToast(
                                              msg: S.current
                                                  .diamondConsumeFailed);
                                        }
                                      } else {
                                        bool isMember = ref
                                                .read(myProfileProvider)
                                                ?.isMember ??
                                            false;
                                        if (isMember) {
                                          await EasyLoading.dismiss();
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Arrow on cool down this week');
                                        } else {
                                          await EasyLoading.dismiss();
                                          Navigator.push(context,
                                              MaterialPageRoute<void>(
                                                  builder: (c) {
                                            return SubscribePage(
                                              fromTag: FromTag.duo_snap,
                                            );
                                          }));
                                        }
                                      }
                                    },
                                  ),
                                ],
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
