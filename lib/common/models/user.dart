import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';

class UserInfo {
  int index=0;
  bool arrowed=false;
  bool matched=false;
  bool skipped=false;
  UserInfo({
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

  DateTime? likeDate;
  int get age => birthday!.toAge();

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
        avatar: json['avatar'],
        bio: json['description'],
        chatStyleId: json['chatStyleId'],
        photos: photos
    );
  }
}