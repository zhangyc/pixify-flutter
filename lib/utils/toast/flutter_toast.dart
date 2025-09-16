import 'package:flutter_easyloading/flutter_easyloading.dart';

class Fluttertoast{
  static void showToast({String? msg}){
    if(msg!=null){
      EasyLoading.showToast(msg);
    }
  }
}