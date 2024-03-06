import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sona/core/match/util/http_util.dart';
part 'duo_provider.g.dart';
@riverpod
Future<List<SdModel>> getSDModel(GetSDModelRef ref) async {
  List<SdModel> sdmodels=[];
  HttpResult result= await post('/merge-photo/find-model');
  List list=result.data;
  sdmodels=list.map((e) => SdModel.fromJson(e)).toList();
  return sdmodels;
}
class SdModel {
  String? name;
  int? id;

  SdModel({this.name, this.id});

  SdModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}