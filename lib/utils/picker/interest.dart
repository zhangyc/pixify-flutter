import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/interests.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/interests.dart';
import 'package:sona/common/widgets/image/icon.dart';

import '../../common/widgets/button/colored.dart';

Future<dynamic> showHobbiesSelector({
  required BuildContext context,
}) {
  return Navigator.push(context, MaterialPageRoute(builder: (_) => HobbiesSelector()));
}
