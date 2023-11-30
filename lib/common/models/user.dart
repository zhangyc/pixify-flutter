import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/utils/locale/locale.dart';

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
    this.interest=const [],
    this.likeMe=0,
    this.wishList=const [],
  });

  final int id;
  final String? name;
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
  DateTime? likeDate;
  int get age => birthday!.toAge();
  final String? impression;
  int likeMe=0;  //1 喜欢了，0 无
  List<Interest> interest=[];
  List<WishBean> wishList=[];
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final images = json['images'];
    final interestTag = json['interest'];
    final _travelWish = json['travelWish'];

    List<String> photos = [];
    List<Interest> interest = [];
    List<WishBean> wishList = [];

    if (images is List && images.isNotEmpty) {
      if (images.first is String) {
        photos = List<String>.from(images);
      } else if (images.first is Map) {
        photos = images.map<String>((i) => i['attachmentUrl']).toList();
      }
    }
    if(interestTag is List && interestTag.isNotEmpty){
      interest=interestTag.map((e) => Interest.fromJson(e)).toList();
    }
    if(_travelWish is List && _travelWish.isNotEmpty){
      wishList=_travelWish.map((e) => WishBean.fromJson(e)).toList();
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
        interest: interest,
        likeMe: json['likeMe']??0,
        wishList: wishList
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

class Interest {
  String? code;
  String? name;

  Interest({this.code, this.name});

  Interest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
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
    timeType = json['timeType'];
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
    data['timeType'] = this.timeType;
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