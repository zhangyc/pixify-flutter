library global;

import 'package:shared_preferences/shared_preferences.dart';

part './kv_store.dart';

Future<void> init() async {
  kvStore = await SharedPreferences.getInstance();
}