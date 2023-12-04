import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';

class UserInfo {
  UserInfo({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    this.countryId,
    this.countryCode,
    this.countryFlag,
    this.locale,
    required this.avatar,
    this.bio,
    this.chatStyleId,
    this.photos = const <String>[],
    this.allScore,
    this.impression,
    this.originNickname,
    this.currentCity
  });

  final int id;
  final String? name;
  final String? originNickname;
  final Gender? gender;
  final DateTime? birthday;
  final int? countryId;
  final String? countryCode;
  final String? countryFlag;
  final String? locale;
  final String? avatar;
  final String? bio;
  final int? chatStyleId;
  final List<String> photos;
  final String? allScore;
  final String? currentCity;
  DateTime? likeDate;
  int get age => birthday!.toAge();
  final String? impression;
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final images = json['images'];
    List<String> photos = [];

    if (images is List && images.isNotEmpty) {
      if (images.first is String) {
        photos = List<String>.from(images);
      } else if (images.first is Map) {
        photos = images.map<String>((i) => i['attachmentUrl']).toList();
      }
    }
    return UserInfo(
        id: json['id'],
        name: json['nickname'],
        gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
        birthday: json['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch(json['birthday']) : null,
        locale: json['lang'],
        countryId: json['countryId'],
        countryCode: json['countryCode'],
        countryFlag: json['countryFlag'],
        avatar: json['avatar'],
        bio: json['description'],
        chatStyleId: json['chatStyleId'],
        photos: photos,
        allScore: json['allScore']?.toStringAsFixed(2),
        impression:json['impression'],
        originNickname:json['originNickname'],
        currentCity:json['currentCity']

    );
  }

  factory UserInfo.fromFirestore(Map<String, dynamic> json) {
    return UserInfo(
        id: json['id'],
        name: json['originalNickname'],
        gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
        birthday: json['birthday'] != null ? (json['birthday'] as Timestamp).toDate() : null,
        locale: json['lang'],
        countryId: json['countryId'],
        countryCode: json['countryCode'],
        countryFlag: json['countryFlag'] ?? '🇺🇸',
        avatar: json['avatar'],
        bio: json['description']
    );
  }
}