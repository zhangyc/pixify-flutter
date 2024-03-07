import '../utils/global/global.dart';

bool get isShowDuoSnapGuide => appCommonBox.get('isShowDuoSnapGuide',defaultValue: false);
set isShowDuoSnapGuide(value){
  appCommonBox.put('isShowDuoSnapGuide', value);
}
bool get isDuoSnapSuccess => appCommonBox.get('isDuoSnapSuccess',defaultValue: false);
set isDuoSnapSuccess(value){
  appCommonBox.put('isDuoSnapSuccess', value);
}