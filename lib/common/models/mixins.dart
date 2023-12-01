import 'package:sona/common/models/user_base_info.dart';

/// 业务数据尽量不要污染UserInfo，使用mixin解决

mixin UserWishList on UserBaseInfo {
  late final List<String> wishList;
}

mixin UserPhotos on UserBaseInfo {
  late final List<String> photos;
}

mixin UserLocation on UserBaseInfo {
  late final int countryId;
  late final String countryName;
  late final String countryFlag;
  late final String cityName;
}

mixin UserLocale on UserBaseInfo {
  late final String locale;
}

mixin UserHobbies on UserBaseInfo {
  late final List<String> hobbies;
}

mixin UserRelation on UserBaseInfo {
  late int relation;
  late DateTime updateTime;
}
