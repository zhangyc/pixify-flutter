library global;

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';
import 'package:sona/utils/security/jwt_decoder.dart';

import '../../account/models/my_profile.dart';
import '../../core/match/util/local_data.dart';
import '../http/interceptors/base.dart';

part './kv_store.dart';
part './dio.dart';
part './navigator_key.dart';
part './token.dart';
part './analytics.dart';
part './route_observer.dart';
part './profile.dart';

Future<void> init() async {
  kvStore = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  appCommonBox=await Hive.openBox('setting-box');
  openAppCount+=1;
}