import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

const plusAnnuallyId = '1_annually';
const plusBiannuallyId = '1_biannually';
const plusQuarterlyId = '1_quarter';
const plusMonthlyId = '1_month';
const plusSubscriptionIds = [plusMonthlyId, plusQuarterlyId, plusBiannuallyId, plusAnnuallyId];
const clubMonthlyId = 'club_monthly';
const clubSubscriptionIds = [clubMonthlyId];

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
  Future<List<ProductDetails>> build() async{
    if (Platform.isIOS) {
      final iosPlatformAddition = InAppPurchase.instance.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      ///设置代理
      await iosPlatformAddition.setDelegate(IOSPaymentQueueDelegate());
    }

    final resp = await InAppPurchase.instance.queryProductDetails({...plusSubscriptionIds, ...clubSubscriptionIds});

    return resp.productDetails;
  }
}

final asyncSubscriptionsProvider = AsyncNotifierProvider<AsyncSubscriptionsNotifier, List<ProductDetails>>(
  () => AsyncSubscriptionsNotifier()
);