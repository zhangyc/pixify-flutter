import 'package:flutter/material.dart';
import 'package:sona/utils/toast/flutter_toast.dart';

import '../../generated/l10n.dart';

Future coolDownDaily() async {
  return Fluttertoast.showToast(
    msg: S.current.toastHitDailyMaximumLimit,
  );
}

Future coolDownWeekly() async{
  return Fluttertoast.showToast(
      msg: S.current.toastHitWeeklyMaximumLimit,

  );
}