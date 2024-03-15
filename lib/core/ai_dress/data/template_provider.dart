import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/ai_dress/bean/sd_template.dart';
import 'package:sona/core/match/bean/duosnap_task.dart';

import '../../match/util/http_util.dart';

final dataSoleProvider = FutureProvider<List<SdTemplate>>((ref) async {
  HttpResult httpResult=await post('/merge-photo/find-model',data: {
    "modelType":'SOLO'
  });
  if(httpResult.isSuccess){
    List list =httpResult.data;
    return list.map((e) => SdTemplate.fromJson(e)).toList();
  }
  return [];
});
final dataDuoSnapProvider = FutureProvider<List<SdTemplate>>((ref) async {
  HttpResult httpResult=await post('/merge-photo/find-model',data: {
    "modelType":'DUAL'
  });
  if(httpResult.isSuccess){
    List list =httpResult.data;
    return list.map((e) => SdTemplate.fromJson(e)).toList();
  }
  return [];
});
final recordProvider = FutureProvider<List<DuoSnapTask>>((ref) async {
  HttpResult httpResult=await post('/merge-photo/list', data:{
    "page": 1, // 页码
    "pageSize": 20 // 每页行数
  });
  if(httpResult.isSuccess){
    List list =httpResult.data['list'];
    return list.map((e) => DuoSnapTask.fromJson(e)).toList();
  }
  return [];
});