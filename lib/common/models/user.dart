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
    this.photos = const <String>[],
    this.allScore,
    this.impression,
    this.interest=const [],
  });

  final int id;
  final String? name;
  final Gender? gender;
  final DateTime? birthday;
  final String? avatar;
  final String? bio;
  final int? chatStyleId;
  final List<String> photos;
  final String? allScore;
  DateTime? likeDate;
  int get age => birthday!.toAge();
  final String? impression;
  List<Interest> interest=[];
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final images = json['images'];
    final _interestTag = json['interest'];
    List<String> photos = [];
    List<Interest> _interest = [];

    if (images is List && images.isNotEmpty) {
      if (images.first is String) {
        photos = List<String>.from(images);
      } else if (images.first is Map) {
        photos = images.map<String>((i) => i['attachmentUrl']).toList();
      }
    }
    if(_interestTag is List && _interestTag.isNotEmpty){
      _interest=_interestTag.map((e) => Interest.fromJson(e)).toList();
    }
    return UserInfo(
        id: json['id'],
        name: json['nickname'],
        gender: json['gender'] != null ? Gender.fromIndex(json['gender']) : null,
        birthday: json['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch(json['birthday']) : null,
        avatar: json['avatar'],
        bio: json['description'],
        chatStyleId: json['chatStyleId'],
        photos: photos,
        allScore: json['allScore']?.toStringAsFixed(2),
        impression:json['impression'],
        interest: _interest

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