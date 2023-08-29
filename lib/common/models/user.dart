import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';

class UserInfo {
  const UserInfo({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.avatar,
    this.bio,
    this.chatStyleId,
    this.photos = const <String>[]
  });

  final int id;
  final String? name;
  final Gender? gender;
  final DateTime? birthday;
  final String? avatar;
  final String? bio;
  final int? chatStyleId;
  final List<String> photos;

  int get age => birthday!.toAge();

  factory UserInfo.fromJson(Map<String, dynamic> json) {
      return UserInfo(
          id: json['id'],
          name: json['nickname'],
          gender: json['gender'] != null ? Gender.values.firstWhere((g) => g.value == json['gender']) : null,
          birthday: json['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch(json['birthday']) : null,
          avatar: json['avatar'],
          bio: json['description'],
          chatStyleId: json['chatStyleId'],
          photos: List<String>.from(json['images'] ?? [])
      );
  }
}