import '../utils/global/global.dart';

bool get isShowDuoSnapGuide => appCommonBox.get('isShowDuoSnapGuide',defaultValue: false);
set isShowDuoSnapGuide(value){
  appCommonBox.put('isShowDuoSnapGuide', value);
}
bool get isDuoSnapSuccess => appCommonBox.get('isDuoSnapSuccess',defaultValue: false);
set isDuoSnapSuccess(value){
  appCommonBox.put('isDuoSnapSuccess', value);
}
double get viewInsetsBottom => appCommonBox.get('viewInsetsBottom',defaultValue: 282.0);
set viewInsetsBottom(value){
  appCommonBox.put('viewInsetsBottom', value);
}

bool get firstShare => appCommonBox.get('firstShare',defaultValue: false);
set firstShare(value){
  appCommonBox.put('firstShare', value);
}
bool get freeTag => appCommonBox.get('freeTag',defaultValue: true);
set freeTag(value){
  appCommonBox.put('freeTag', value);
}