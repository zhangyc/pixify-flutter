import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/utils/global/global.dart';

import '../../../utils/dialog/subsciption.dart';
import '../../../utils/toast/cooldown.dart';
import '../../subscribe/subscribe_page.dart';
import '../models/message.dart';
import '../services/chat.dart';

class SonaTips {
  const SonaTips({required this.tips, required this.options});
  final String? tips;
  final List<String> options;
}

class AsyncSonaTipsNotifier extends AutoDisposeFamilyAsyncNotifier<SonaTips, int> {
  @override
  FutureOr<SonaTips> build(arg) async {
    final resp = await callSona(
        userId: arg,
        type: CallSonaType.SUGGEST_V2
    );
    if (resp.statusCode == 10150) {
      if (ref.read(myProfileProvider)!.isMember) {
        coolDownWeekly();
        SonaAnalytics.log('sona_tips_hit_maximum_limit:plus');
      } else {
        showSubscription(FromTag.pay_chat_suggest);
        SonaAnalytics.log('sona_tips_hit_maximum_limit:non-plus');
      }
      throw Error();
    }
    final data = resp.data['optionV2'] as Map;
    final tips = data['tips'] as String?;
    final options = data['suggestions'] as List;
    if (options.isEmpty) throw Error();
    return SonaTips(tips: tips, options: options.cast<String>());
  }
}

final asyncSonaTipsProvider = AsyncNotifierProvider.autoDispose.family<
    AsyncSonaTipsNotifier,
    SonaTips,
    int
>(() => AsyncSonaTipsNotifier());