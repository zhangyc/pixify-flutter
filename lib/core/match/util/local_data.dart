

import 'package:intl/intl.dart';
import 'package:sona/utils/global/global.dart';


int? get currentFilterGender => appCommonBox.get('currentFilterGender',defaultValue: null); ///默认为all
set currentFilterGender(value){
  appCommonBox.put('currentFilterGender', value);
}
int get currentFilterMinAge => appCommonBox.get('currentFilterMinAge',defaultValue: 18);
set currentFilterMinAge(value){
  appCommonBox.put('currentFilterMinAge', value);
}
int get currentFilterMaxAge => appCommonBox.get('currentFilterMaxAge',defaultValue: 80);
set currentFilterMaxAge(value){
  appCommonBox.put('currentFilterMaxAge', value);
}

double? get longitude => appCommonBox.get('longitude',defaultValue: null);
set longitude(value){
  appCommonBox.put('longitude', value);
}
double? get latitude => appCommonBox.get('latitude',defaultValue: null);
set latitude(value){
  appCommonBox.put('latitude', value);
}
bool get isShowArrowReward => appCommonBox.get('isShowArrowReward',defaultValue: true);
set isShowArrowReward(value){
  appCommonBox.put('isShowArrowReward', value);
}
bool get showGuideAnimation => appCommonBox.get('showGuideAnimation',defaultValue: true);
set showGuideAnimation(value){
  appCommonBox.put('showGuideAnimation', value);
}
String get recommendMode => appCommonBox.get('recommendMode',defaultValue: "WISH");
set recommendMode(value){
  appCommonBox.put('recommendMode', value);
}
bool get showCatchMore => appCommonBox.get('showCatchMore',defaultValue: true);
set showCatchMore(value){
  appCommonBox.put('showCatchMore', value);
}
int get openAppCount => appCommonBox.get('openAppCount',defaultValue: 0);
set openAppCount(value){
  appCommonBox.put('openAppCount', value);
}
bool get todayIsShowedTimed => appCommonBox.get('${DateFormat('yyyy.MM.dd').format(DateTime.now())}todayIsShowedTimed',defaultValue: true);
set todayIsShowedTimed(value){
  appCommonBox.put('${DateFormat('yyyy.MM.dd').format(DateTime.now())}todayIsShowedTimed', value);
}
int get showTimeLimitedCount => appCommonBox.get('showTimeLimitedCount',defaultValue: 0);
set showTimeLimitedCount(value){
  appCommonBox.put('showTimeLimitedCount', value);
}