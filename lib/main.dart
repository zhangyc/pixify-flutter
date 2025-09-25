import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sona/firebase/sona_firebase.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/core/astro/engine/astro_calc.dart';
import 'package:sweph/sweph.dart';

import 'app.dart';
import 'core/match/util/iap_helper.dart';
import 'core/travel_wish/models/country.dart';
import 'firebase_options.dart';
import 'utils/global/global.dart' as global;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await initSweph([
    'assets/ephe/seas_18.se1', // For house calc
    'assets/ephe/sefstars.txt', // For star position
    'assets/ephe/seasnam.txt', // For asteriods
  ]);

  ///后台消息处理
  initHelper();
  final firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'sona');
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    appleProvider: kDebugMode ? AppleProvider.debug : AppleProvider.appAttest,
  );
  purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((p) {
      if (p.status == PurchaseStatus.purchased ||
          p.status == PurchaseStatus.restored) {
        InAppPurchase.instance.completePurchase(p);
      }
    });
  }, onDone: () {
    // _subscription.cancel();
  }, onError: (Object error) {
    // if (kDebugMode) print(error);
  });

  ///成功初始化firebase app。
  if (firebase.name == 'sona') {
    initFireBaseService(firebase);
  }
  await global.init();
  SonaAnalytics.init();
  // unawaited(_initAttribution());
  // 先放这，以后整理
  countryMapList =
      (jsonDecode(await rootBundle.loadString('assets/i18n/countries.json'))
              as List)
          .map((d) => d as Map<String, dynamic>)
          .toList(growable: false);

  if (kDebugMode) {
    await _testAstroCalc();
  }

  runApp(ProviderScope(child: const SonaApp()));
}

// Future<void> _initAttribution() async {
//   if (kDebugMode) return;
//   AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
//       afDevKey: 'pjgPTCev87vC2WK6dGhg3n',
//       appId: Platform.isIOS ? '6464375495' : 'com.solararrow.pixify',
//       showDebug: kDebugMode,
//       timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
//       disableAdvertisingIdentifier: Platform.isIOS,
//       disableCollectASA: Platform.isIOS
//   );
//   AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
//   await appsflyerSdk.initSdk();
// }
class _RootBundleAssetLoader implements AssetLoader {
  @override
  Future<Uint8List> load(String assetPath) async {
    return (await rootBundle.load(assetPath)).buffer.asUint8List();
  }
}

Future<void> initSweph([List<String> epheAssets = const []]) async {
  final epheFilesPath =
      '${(await getApplicationSupportDirectory()).path}/ephe_files';

  await Sweph.init(
    epheAssets: epheAssets,
    epheFilesPath: epheFilesPath,
    assetLoader: _RootBundleAssetLoader(),
  );
}

Future<void> _testAstroCalc() async {
  try {
    // 示例 A：上海 1996-07-15 18:30（本地时，东八区）
    final chartA = AstroCalc.computeNatalChart(
      birthLocal: DateTime(1996, 7, 15, 18, 30),
      geoLat: 31.2304,
      geoLon: 121.4737,
      timeZoneOffsetHours: 8.0,
    );

    // 示例 B：北京 1994-03-21 09:15（本地时，东八区）
    final chartB = AstroCalc.computeNatalChart(
      birthLocal: DateTime(1994, 3, 21, 9, 15),
      geoLat: 39.9042,
      geoLon: 116.4074,
      timeZoneOffsetHours: 8.0,
    );

    final syn = AstroCalc.computeSynastry(chartA: chartA, chartB: chartB);

    debugPrint('AstroCalc Natal A: ' + jsonEncode(chartA.toJson()));
    debugPrint('AstroCalc Natal B: ' + jsonEncode(chartB.toJson()));
    log(
      'AstroCalc Synastry: ' + jsonEncode(syn.toJson()),
    );
  } catch (e, st) {
    debugPrint('AstroCalc test error: $e\n$st');
  }
}
