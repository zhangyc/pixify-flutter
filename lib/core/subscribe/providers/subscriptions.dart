import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

var plusAnnuallyId = '1_annually';
var plusBiannuallyId = '1_biannually';
var plusQuarterlyId = '1_quarter';
var plusMonthlyId = '1_month';

var plusSubscriptionIds = [
  plusMonthlyId,
  plusQuarterlyId,
  plusBiannuallyId,
  plusAnnuallyId
];

class IOSPaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return false;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

class AsyncSubscriptionsNotifier extends AsyncNotifier<List<ProductDetails>> {
  @override
  Future<List<ProductDetails>> build() async {
    if (Platform.isIOS) {
      final iosPlatformAddition = InAppPurchase.instance
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();

      ///设置代理
      await iosPlatformAddition.setDelegate(IOSPaymentQueueDelegate());
    }

    final resp = await InAppPurchase.instance.queryProductDetails({
      ...plusSubscriptionIds,
    });

    if (resp.productDetails.isEmpty) throw ();
    return resp.productDetails;
  }
}

final asyncSubscriptionsProvider =
    AsyncNotifierProvider<AsyncSubscriptionsNotifier, List<ProductDetails>>(
        () => AsyncSubscriptionsNotifier());
