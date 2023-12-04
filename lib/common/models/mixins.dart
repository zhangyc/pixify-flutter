import 'package:sona/common/models/base_user.dart';

/// 业务数据尽量不要污染UserInfo，使用mixin解决

mixin UserWishList on BaseUser {
  late final List<String> wishList;
}

mixin UserPhotos on BaseUser {
  late final List<String> photos;
}

mixin UserNationality on BaseUser {
  late final int? countryId;
  late final String? countryCode;
  late final String? countryName;
  late final String? countryFlag;
}

mixin UserPosition on BaseUser {
  late final String currentCityName;
}

mixin UserLocale on BaseUser {
  late final String locale;
}

mixin UserHobbies on BaseUser {
  late final List<String> hobbies;
}

mixin UserRelation on BaseUser {
  late int? relation;
  late DateTime? updateTime;
}
