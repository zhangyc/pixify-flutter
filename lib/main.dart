import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sona/firebase/sona_firebase.dart';

import 'app.dart';
import 'core/match/util/iap_helper.dart';
import 'core/travel_wish/models/country.dart';
import 'firebase_options.dart';
import 'utils/global/global.dart' as global;
import 'utils/providers/app_lifecycle.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler); ///后台消息处理
  initHelper();
  final firebase = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'sona'
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    appleProvider: kDebugMode ? AppleProvider.debug : AppleProvider.appAttest,
  );
  purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((p) {
      if(p.status==PurchaseStatus.purchased||p.status==PurchaseStatus.restored){
        InAppPurchase.instance.completePurchase(p);
      }
    });
  }, onDone: () {
    // _subscription.cancel();
  }, onError: (Object error) {
    // if (kDebugMode) print(error);
  });
  ///成功初始化firebase app。
  if(firebase.name=='sona'){
    initFireBaseService(firebase);
  }
  await global.init();
  // unawaited(_initAttribution());
  // 先放这，以后整理
  countryMapList = (jsonDecode(await rootBundle.loadString('assets/i18n/countries.json')) as List)
    .map((d) => d as Map<String, dynamic>)
    .toList(growable: false);
  runApp(
    ProviderScope(
      child: const SonaApp()
    )
  );
}

// Future<void> _initAttribution() async {
//   if (kDebugMode) return;
//   AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
//       afDevKey: 'pjgPTCev87vC2WK6dGhg3n',
//       appId: Platform.isIOS ? '6464375495' : 'com.planetwalk.sona',
//       showDebug: kDebugMode,
//       timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
//       disableAdvertisingIdentifier: Platform.isIOS,
//       disableCollectASA: Platform.isIOS
//   );
//   AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
//   await appsflyerSdk.initSdk();
// }
