import 'package:geolocator/geolocator.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/account/models/hobby.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/subscribe/model/member.dart';

class MyProfile {
  const MyProfile(
      {required this.id,
      required this.name,
      required this.gender,
      required this.birthday,
      required this.countryId,
      this.countryCode,
      this.countryFlag,
      required this.avatar,
      this.interests = const <UserHobby>[],
      required this.position,
      this.pushEnabled = true,
      this.bio,
      this.impression,
      this.chatStyleId,
      this.photos = const <ProfilePhoto>[],
      this.locale,
      this.cityVisibility = true,
      this.birthCity,
      this.birthLatitude,
      this.birthLongitude,
      // required this.memberType,
      required this.vipEndDate});

  final int id;
  final String? name;
  final Gender? gender;
  final DateTime? birthday;
  final int? countryId;
  final String? countryCode;
  final String? countryFlag;
  final String? avatar;
  final String? bio;
  final String? impression;
  final int? chatStyleId;
  final List<UserHobby> interests;
  final List<ProfilePhoto> photos;
  final Position? position;
  final bool pushEnabled;
  final String? locale;
  final bool cityVisibility;
  final String? birthCity;
  final String? birthLatitude;
  final String? birthLongitude;
  // final MemberType memberType;
  final int? vipEndDate;

  bool get completed => _validate();
  bool get isMember {
    if (vipEndDate == null) return false;
    // vipEndDate是毫秒时间戳，需要转换为秒
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(vipEndDate!);
    final now = DateTime.now();
    return expiryDate.isAfter(now);
  }

  factory MyProfile.fromJson(Map<String, dynamic> json) {
    final longitudeStr = json['longitude'];
    final latitudeStr = json['latitude'];
    Position? pos;
    if (longitudeStr != null && latitudeStr != null) {
      pos = Position.fromMap({
        'longitude': double.tryParse(longitudeStr),
        'latitude': double.tryParse(latitudeStr),
        'timestamp': json['modifyDate'] ??
            json['createDate'] ??
            DateTime.now().millisecondsSinceEpoch
      });
    }
    return MyProfile(
      id: json['id'],
      name: json['nickname'],
      gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
      birthday:
          json['birthday'] != null ? DateTime.tryParse(json['birthday']) : null,
      countryId: json['countryId'],
      countryCode: json['countryCode'],
      countryFlag: json['countryFlag'],
      avatar: json['avatar'],
      bio: json['description'],
      impression: json['impression'],
      chatStyleId: json['chatStyleId'],
      vipEndDate: json['vipEndDate'],
      interests: json['interestList'] != null
          ? (json['interestList'] as List)
              .map<UserHobby>((json) => UserHobby.fromJson(json))
              .toList()
          : [],
      photos: json['images'] != null
          ? (json['images'] as List)
              .map<ProfilePhoto>((photo) => ProfilePhoto.fromJson(photo))
              .toList()
          : <ProfilePhoto>[],
      position: pos,
      pushEnabled: json['openPush'] ?? true,
      locale: json['lang'],
      cityVisibility: json['showCity'] ?? true,
      birthCity: json['birthCity'],
      birthLatitude: json['birthLatitude'],
      birthLongitude: json['birthLongitude'],
      // memberType: MemberType.fromString(json['vip'])
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nickname': name,
      'gender': gender?.index,
      'birthday': birthday?.toString(),
      'countryId': countryId,
      'countryCode': countryCode,
      'countryFlag': countryFlag,
      'avatar': avatar,
      'description': bio,
      'impression': impression,
      'chatStyleId': chatStyleId,
      'interestList': interests.map((hb) => hb.toJson()).toList(),
      'images':
          photos.map<Map<String, dynamic>>((photo) => photo.toJson()).toList(),
      'longitude': position?.longitude.toString(),
      'latitude': position?.latitude.toString(),
      'openPush': pushEnabled,
      'lang': locale,
      'showCity': cityVisibility,
      'birthCity': birthCity,
      'birthLatitude': birthLatitude,
      'birthLongitude': birthLongitude,
      'vipEndDate': vipEndDate,
      // 'vip': memberType.name
    };
  }

  bool _validate() {
    return name != null &&
        gender != null &&
        birthday != null
        // && (avatar != null && avatar!.isNotEmpty)
        &&
        locale != null;
    // && countryId != null;
  }

  UserInfo toUser() {
    return UserInfo(
        id: id,
        name: name,
        avatar: avatar,
        birthday: birthday,
        countryId: countryId,
        countryCode: countryCode,
        countryFlag: countryFlag,
        locale: locale,
        gender: gender,
        bio: bio,
        photos: photos.map((photo) => photo.url).toList(),
        birthCity: birthCity,
        birthLatitude: birthLatitude,
        birthLongitude: birthLongitude);
  }

  MyProfile copyWith({bool? pushEnabled, bool? cityVisibility}) {
    final json = toJson();
    return MyProfile.fromJson(json
      ..['openPush'] = pushEnabled ?? json['openPush']
      ..['showCity'] = cityVisibility ?? json['showCity']);
  }
}

class ProfilePhoto {
  const ProfilePhoto({required this.id, required this.url});
  final int id;
  final String url;
  factory ProfilePhoto.idle(int id, String url) {
    return ProfilePhoto(id: id, url: url);
  }
  factory ProfilePhoto.fromJson(Map<String, dynamic> json) {
    return ProfilePhoto(id: json['id'], url: json['attachmentUrl']);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'attachmentUrl': url};
}
