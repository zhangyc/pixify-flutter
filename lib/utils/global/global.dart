library global;

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sona/account/providers/profile.dart';

import '../http/interceptors/base.dart';

part './kv_store.dart';
part './dio.dart';
part './navigator_key.dart';
part './token.dart';

Future<void> init() async {
  kvStore = await SharedPreferences.getInstance();
}