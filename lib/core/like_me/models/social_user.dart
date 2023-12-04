import 'package:sona/common/models/mixins.dart';
import 'package:sona/common/models/base_user.dart';

class SocialUser extends BaseUser with UserNationality, UserLocale, UserRelation {
  SocialUser.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    countryId = json['countryId'];
    countryCode = json['countryCode'];
    countryName = json['countryName'];
    countryFlag = json['countryFlag'];

    locale = json['lang'];

    updateTime = json['likeDate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['likeDate']!) : null;
  }
}