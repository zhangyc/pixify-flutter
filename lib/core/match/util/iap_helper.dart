import 'package:in_app_purchase/in_app_purchase.dart';

final InAppPurchase inAppPurchase = InAppPurchase.instance;
late Stream<List<PurchaseDetails>> purchaseUpdated;
void initHelper(){
  purchaseUpdated = inAppPurchase.purchaseStream;
}