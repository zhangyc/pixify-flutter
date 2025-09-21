import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/util/http_util.dart';

final getSDModelProvider = FutureProvider<List<SdModel>>((ref) async {
  return getSDModel();
});

Future<List<SdModel>> getSDModel() async {
  List<SdModel> sdmodels = [];
  HttpResult result = await post('/merge-photo/find-model');
  List list = result.data;
  sdmodels = list.map((e) => SdModel.fromJson(e)).toList();
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
