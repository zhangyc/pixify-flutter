import 'package:flutter/material.dart';

import '../../core/subscribe/subscribe_page.dart';
import '../global/global.dart';

Future showSubscription() {
  return navigatorKey.currentState!.push(MaterialPageRoute(builder:(c){
    return const SubscribePage();
  }));
}