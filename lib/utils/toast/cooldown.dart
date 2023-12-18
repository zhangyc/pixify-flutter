import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../generated/l10n.dart';

Future coolDownDaily() {
  return Fluttertoast.showToast(
    msg: S.current.toastHitDailyMaximumLimit,
    backgroundColor: Colors.redAccent,
    textColor: Colors.white
  );
}

Future coolDownWeekly() {
  return Fluttertoast.showToast(
      msg: S.current.toastHitWeeklyMaximumLimit,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white
  );
}