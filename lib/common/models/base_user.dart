import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';

class BaseUser {
  BaseUser({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.avatar,
    required this.bio
  });

  late final int id;
  late final String? name;
  late final Gender? gender;
  late final DateTime? birthday;
  late final String? avatar;
  late final String? bio;

  int get age => birthday!.toAge();

  BaseUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] ;
    name = json['nickname'] ;
    gender = json['gender'] != null ? Gender.fromIndex(json['gender']) : null ;
    birthday = json['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch(json['birthday']) : null ;
    avatar = json['avatar'] ;
    bio = json['description'] ;
  }

  BaseUser.fromFirestore(Map<String, dynamic> json) {
    id = json['id'] ;
    name = json['originalNickname'] ;
    gender = json['gender'] != null ? Gender.fromIndex(json['gender']) : null ;
    birthday = json['birthday'] != null ? (json['birthday'] as Timestamp).toDate() : null ;
    avatar = json['avatar'] ;
    bio = json['description'];
  }
}
