import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/account/models/hobby.dart';
import 'package:sona/core/subscribe/model/member.dart';

import '../../../common/models/user.dart';
import '../enums/astro_badge_type.dart';
import 'astro_score.dart';

class DiscoverUser extends UserInfo{
  int index=0;
  bool arrowed=false;
  bool matched=false;
  bool skipped=false;
  bool liked=false;
  bool isOnline=false;
  DiscoverUser({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.countryFlag,
    this.locale,
    required this.avatar,
    this.bio,
    this.chatStyleId,
    this.photos = const <String>[],
    this.allScore,
    this.impression,
    this.interest=const [],
    this.likeMe=0,
    this.wishList=const [],
    this.originNickname,
    this.currentCity,
    this.likeActivityName,
    this.memberType
  }) : super(id: id,
    name: name,
    originNickname: originNickname,
    gender: gender,
    birthday: birthday,
    countryId: countryId,
    countryCode: countryCode,
    countryName: countryName,
    countryFlag: countryFlag,
    locale: locale,
    avatar: avatar,
    bio: bio,
    chatStyleId: chatStyleId,
    photos: photos,
    allScore: allScore,
    currentCity: currentCity,
    impression: impression,
  );
  @override
  final int id;
  @override
  final String? name;
  @override
  final String? originNickname;
  @override
  final Gender? gender;
  @override
  final DateTime? birthday;
  @override
  final int? countryId;
  @override
  final String? countryCode;
  @override
  final String? countryName;
  @override
  final String? countryFlag;
  @override
  final String? locale;
  @override
  final String? avatar;
  @override
  final String? bio;
  @override
  final int? chatStyleId;
  @override
  final List<String> photos;
  @override
  final String? allScore;
  @override
  final String? currentCity;
  @override
  DateTime? likeDate;
  @override
  int get age => birthday?.toAge()??0;
  @override
  final String? impression;

  final MemberType? memberType;
  AstroScore? astroScore=AstroScore(fate: 8, harmony: 1, risk: 3);
  double? distance=2.4;
  DateTime? lastActive;
  int likeMe=0;  //1 喜欢了，0 无
  List<UserHobby> interest=[];
  List<WishBean> wishList=[];
  String? likeActivityName; // 喜欢的原因，点击喜欢时选中的活动名称
  factory DiscoverUser.fromJson(Map<String, dynamic> json) {
    final images = json['images'];
    final interestTag = json['interest'];
    final _travelWish = json['travelWish'];

    List<String> photos = [];
    List<UserHobby> interest = [];
    List<WishBean> wishList = [];

    if (images is List && images.isNotEmpty) {
      if (images.first is String) {
        photos = List<String>.from(images);
      } else if (images.first is Map) {
        photos = images.map<String>((i) => i['attachmentUrl']).toList();
      }
    }
    if(interestTag is List && interestTag.isNotEmpty){
      interest=interestTag.map((e) => UserHobby.fromJson(e)).toList();
    }
    if(_travelWish is List && _travelWish.isNotEmpty){
      wishList=_travelWish.map((e) => WishBean.fromJson(e)).toList();
    }
    return DiscoverUser(
        id: json['id'],
        name: json['nickname'],
        gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
        birthday: json['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch(json['birthday']) : null,
        locale: json['lang'],
        countryId: json['countryId'],
        countryCode: json['countryCode'],
        countryName: json['countryName'],
        countryFlag: json['countryFlag'],
        avatar: json['avatar'],
        bio: json['description'],
        chatStyleId: json['chatStyleId'],
        photos: photos,
        allScore: json['allScore']?.toStringAsFixed(2),
        impression:json['impression'],
        interest: interest,
        likeMe: json['likeMe']??0,
        wishList: wishList,
        originNickname:json['originNickname'],
        currentCity:json['currentCity'],
        likeActivityName:json['likeActivityName'],
        memberType: MemberType.fromString(json['vip'])
    );
  }

  factory DiscoverUser.fromFirestore(Map<String, dynamic> json) {
    return DiscoverUser(
        id: json['id'],
        name: json['originalNickname'],
        gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
        birthday: json['birthday'] != null ? (json['birthday'] as Timestamp).toDate() : null,
        locale: json['lang'],
        countryId: json['countryId'],
        countryCode: json['countryCode'],
        countryFlag: json['countryFlag'] ?? '🇺🇸',
        countryName: json['countryName'],
        avatar: json['avatar'],
        bio: json['description'],
        memberType: MemberType.fromString(json['vip'])
    );
  }
  factory DiscoverUser.fromUserInfoInstance(UserInfo userInfo) {
    return DiscoverUser(
      id: userInfo.id,
      name: userInfo.originNickname,
      gender: userInfo.gender,
      birthday: userInfo.birthday,
      locale: userInfo.locale,
      countryId: userInfo.countryId,
      countryCode: userInfo.countryCode,
      countryFlag: userInfo.countryFlag ?? '🇺🇸',
      countryName: userInfo.countryName,
      avatar: userInfo.avatar,
      bio: userInfo.bio,
    );
  }
}

class WishBean {
  int? id;
  int? createDate;
  int? modifyDate;
  int? userId;
  String? title;
  int? countryId;
  String? countryName;
  String? cityId;
  String? cityName;
  String? pic;
  String? timeType;
  int? endDate;
  String? activityIds;
  String? activityNames;
  int? status;
  String? countryFlag;
  List<Activity> activities=[];
  WishBean(
      {this.id,
        this.createDate,
        this.modifyDate,
        this.userId,
        this.title,
        this.countryId,
        this.countryName,
        this.cityId,
        this.cityName,
        this.pic,
        this.timeType,
        this.endDate,
        this.activityIds,
        this.activityNames,
        this.status,
        this.countryFlag,
        this.activities=const []
      });

  WishBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    modifyDate = json['modifyDate'];
    userId = json['userId'];
    title = json['title'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    pic = json['pic'];
    timeType = json['timeTypeName'];
    endDate = json['endDate'];
    activityIds = json['activityIds'];
    activityNames = json['activityNames'];
    status = json['status'];
    countryFlag = json['countryFlag'];
    List t=json['activity']??[];
    activities=t.map((e) => Activity.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['modifyDate'] = this.modifyDate;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['pic'] = this.pic;
    data['timeTypeName'] = this.timeType;
    data['endDate'] = this.endDate;
    data['activityIds'] = this.activityIds;
    data['activityNames'] = this.activityNames;
    data['status'] = this.status;
    data['countryFlag'] = this.countryFlag;
    data['activity']=this.activities;

    return data;

  }
}
class Activity {
  int? id;
  String? title;
  bool selected=false;
  Activity({this.id, this.title});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}



