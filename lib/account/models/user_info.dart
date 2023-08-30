import 'package:geolocator/geolocator.dart';
import 'package:sona/account/models/gender.dart';

class MyInfo {
  const MyInfo({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.avatar,
    required this.interests,
    required this.position,
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
  final List<String> interests;
  final List<String> photos;
  final Position position;

  bool get completed => _validate();

  factory MyInfo.fromJson(Map<String, dynamic> json) {
    return MyInfo(
      id: json['id'],
      name: json['nickname'],
      gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
      birthday: json['birthday'] != null ? DateTime.tryParse(json['birthday']) : null,
      avatar: json['avatar'],
      bio: json['description'],
      chatStyleId: json['chatStyleId'],
      interests: json['interest'] != null ? (json['interest'] as String).split(',') : [],
      photos: json['images'] != null ? (json['images'] as List).map<String>((photo) => photo['attachmentUrl']).toList() : [],
      position: Position.fromMap({'longitude': double.parse(json['longitude']), 'latitude': double.parse(json['latitude'])})
    );
  }

  bool _validate() {
    return name != null
        && gender != null
        && birthday != null
        && avatar != null
        && interests.length >= 3;
  }
}