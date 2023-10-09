// 1. 创建一个Notifier管理分页状态
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/setting.dart';
import 'package:sona/core/match/util/http_util.dart';

import '../screens/match.dart';
import '../widgets/filter_dialog.dart';

// Riverpod providers

// Page controller provider
final pageControllerProvider = StateProvider((ref) => PageController());

// Users provider
final usersProvider = StateNotifierProvider<UsersNotifier, List<UserInfo>>((ref) {
  return UsersNotifier();
});

// Users notifier
class UsersNotifier extends StateNotifier<List<UserInfo>> {

  UsersNotifier() : super([]);

  // Load users page by page
  void getUsers(int page) async {
    // Simulate API request
    int? gender;
    if(currentFilterGender==FilterGender.male.index){
      gender=1;

    }else if(currentFilterGender==FilterGender.female.index){
      gender=2;

    }else if(currentFilterGender==FilterGender.all.index){
      gender=null;
    }
    try{
      final resp=await post('/user/match-v2',data: {
        'gender': gender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page":page,    // 页码
        "pageSize":10 // 每页数量
      });
      if(resp.isSuccess){
        List list= resp.data;
        List<UserInfo> users1=list.map((e) => UserInfo.fromJson(e)).toList();
        if(users1.isEmpty){
          users1.add(UserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null));
        }
        for (var element in users1) {
          if(element.avatar!=null){
            DefaultCacheManager().downloadFile(element.avatar!);
          }
        }
        state = [...state, ...users1];
      }

    }catch(e){
      if (kDebugMode) print(e);
    }

  }

}

abstract class MatchRepository{
  void loadMore();
}
class MatchRemoteRepository implements MatchRepository{
  @override
  void loadMore() {

  }

}
void _loadMore() async{


}