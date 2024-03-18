import '../../core/match/util/http_util.dart';
import '../../utils/global/global.dart';

int get hook => appCommonBox.get('hook',defaultValue: 0);
set hook(value){
  appCommonBox.put('hook', value);
}
int get arrow => appCommonBox.get('arrow',defaultValue: 0);
set arrow(value){
  appCommonBox.put('arrow', value);
}
int get sona => appCommonBox.get('sona',defaultValue: 0);
set sona(value){
  appCommonBox.put('sona', value);
}
int get suggest => appCommonBox.get('suggest',defaultValue: 0);
set suggest(value){
  appCommonBox.put('suggest', value);
}
int get like => appCommonBox.get('like',defaultValue: 0);
set like(value){
  appCommonBox.put('like', value);
}
int get duosnap => appCommonBox.get('duosnap',defaultValue: 0);
set duosnap(value){
  appCommonBox.put('duosnap', value);
}
int get aiDress => appCommonBox.get('aiDress',defaultValue: 0);
set aiDress(value){
  appCommonBox.put('aiDress', value);
}
bool get showTags => appCommonBox.get('showTags',defaultValue: false);
set showTags(value){
  appCommonBox.put('showTags', value);
}
bool get canHook =>hook>0;
bool get canArrow =>arrow>0;
bool get canSona =>sona>0;
bool get canSuggest =>suggest>0;
bool get canLike =>like>0||like==-1;
bool get canDuoSnap =>duosnap>0;
bool get canAiDress =>aiDress>0;

///初始化用户权限数据
void initUserPermission() async{
  HttpResult result=await post('/user/permission');
  if(result. isSuccess){
    hook=result.data['hook'];
    arrow=result.data['arrow'];
    sona=result.data['sona'];
    suggest=result.data['suggest'];
    like=result.data['like'];
    duosnap=result.data['duoSnap'];
    aiDress=result.data['aiDress'];

  }
}