import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';

class UserBaseInfo {
  UserBaseInfo({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.avatar,
    required this.bio
  });

  final int id;
  final String? name;
  final Gender? gender;
  final DateTime? birthday;
  final String? avatar;
  final String? bio;

  int get age => birthday!.toAge();

  factory UserBaseInfo.fromJson(Map<String, dynamic> json) {
    return UserBaseInfo(
        id: json['id'],
        name: json['nickname'],
        gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
        birthday: json['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch(json['birthday']) : null,
        avatar: json['avatar'],
        bio: json['description'],
    );
  }

  factory UserBaseInfo.fromFirestore(Map<String, dynamic> json) {
    return UserBaseInfo(
        id: json['id'],
        name: json['originalNickname'],
        gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
        birthday: json['birthday'] != null ? (json['birthday'] as Timestamp).toDate() : null,
        avatar: json['avatar'],
        bio: json['description']
    );
  }
}
