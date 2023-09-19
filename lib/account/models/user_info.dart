import 'package:geolocator/geolocator.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/common/models/user.dart';

class MyProfile {
  const MyProfile( {
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.avatar,
    required this.interests,
    required this.position,
    this.bio,
    this.chatStyleId,
    this.photos = const <ProfilePhoto>[],
    required this.vipEndDate,
  });

  final int id;
  final String? name;
  final Gender? gender;
  final DateTime? birthday;
  final String? avatar;
  final String? bio;
  final int? chatStyleId;
  final List<String> interests;
  final List<ProfilePhoto> photos;
  final Position position;
  final int? vipEndDate;

  bool get completed => _validate();
  bool get isMember => vipEndDate != null && vipEndDate! > DateTime.now().millisecondsSinceEpoch;

  factory MyProfile.fromJson(Map<String, dynamic> json) {
    return MyProfile(
      id: json['id'],
      name: json['nickname'],
      gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
      birthday: json['birthday'] != null ? DateTime.tryParse(json['birthday']) : null,
      avatar: json['avatar'],
      bio: json['description'],
      chatStyleId: json['chatStyleId'],
      vipEndDate: json['vipEndDate'],
      interests: json['interest'] != null ? (json['interest'] as String).split(',') : [],
      photos: json['images'] != null ? (json['images'] as List).map<ProfilePhoto>((photo) => ProfilePhoto.fromJson(photo)).toList() : <ProfilePhoto>[],
      position: Position.fromMap({'longitude': double.parse(json['longitude']), 'latitude': double.parse(json['latitude'])})
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nickname': name,
      'gender': gender?.index,
      'birthday': birthday?.toString(),
      'avatar': avatar,
      'description': bio,
      'chatStyleId': chatStyleId,
      'interest': interests.join(','),
      'images': photos.map<Map<String, dynamic>>((photo) => photo.toJson()).toList(),
      'longitude': position.longitude.toString(),
      'latitude': position.latitude.toString(),
      'vipEndDate':vipEndDate
    };
  }

  bool _validate() {
    return name != null
        && gender != null
        && birthday != null
        && avatar != null
        && interests.length >= 3;
  }

  UserInfo toUser() {
    return UserInfo(
      id: id,
      name: name,
      avatar: avatar,
      birthday: birthday,
      gender: gender,
      bio: bio,
      photos: photos.map((photo) => photo.url).toList()
    );
  }
}

class ProfilePhoto {
  const ProfilePhoto({
    required this.id,
    required this.url
  });
  final int id;
  final String url;

  factory ProfilePhoto.fromJson(Map<String, dynamic> json) {
    return ProfilePhoto(
      id: json['id'],
      url: json['attachmentUrl']
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'attachmentUrl': url
  };
}