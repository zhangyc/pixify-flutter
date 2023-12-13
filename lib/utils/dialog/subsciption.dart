import 'package:flutter/material.dart';

import '../../core/subscribe/subscribe_page.dart';
import '../global/global.dart';

Future showSubscription(SubscribeShowType type,FromTag fromTag) {
  return navigatorKey.currentState!.push(MaterialPageRoute(builder:(c){
    return SubscribePage(type,fromTag: fromTag,);
  }));
}