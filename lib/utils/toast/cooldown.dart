import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future coolDown() {
  return Fluttertoast.showToast(
    msg: 'Cool down today',
    backgroundColor: Colors.redAccent,
    textColor: Colors.white
  );
}