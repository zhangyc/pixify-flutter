library global;

import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

part './kv_store.dart';

Future<void> init() async {
  kvStore = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  appCommonBox=await Hive.openBox('setting-box');
}