import 'package:sona/common/models/mixins.dart';
import 'package:sona/common/models/base_user.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/like_me/models/like_me.dart';

class SocialUser extends BaseUser with UserNationality, UserLocale, UserRelation, LikeMe {
  SocialUser.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    countryId = json['countryId'];
    countryCode = json['countryCode'];
    countryName = json['countryName'];
    countryFlag = json['countryFlag'];

    locale = json['lang'];

    updateTime = json['likeDate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['likeDate']!) : null;

    tags = (json['tags'] as List?)?.cast<String>().toList(growable: false);
    hang = json['likeReason'];
  }

  UserInfo toUserInfo() => UserInfo(id: id, name: name, gender: gender, birthday: birthday, avatar: avatar);
}