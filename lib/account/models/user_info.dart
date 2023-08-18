class UserInfo {
  const UserInfo({
    required this.name,
    required this.gender,
    required this.age,
    required this.avatar
  });

  final String? name;
  final int? gender;
  final String? age;
  final String? avatar;

  bool get completed => _validate();

  static const empty = UserInfo(name: '', gender: 1, age: '', avatar: '');

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        name: json['nickname'],
        gender: json['gender'],
        age: json['birthday'],
        avatar: json['avatar']
    );
  }

  UserInfo copyWith(UserInfo info) {
    return UserInfo(
        name: info.name ?? name,
        gender: info.gender ?? gender,
        age: info.age ?? age,
        avatar: info.avatar ?? avatar
    );
  }

  UserInfo copyWithProperties({
    String? name,
    int? gender,
    String? age,
    String? avatar
  }) {
    return UserInfo(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      avatar: avatar ?? this.avatar
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nickname': name,
      'gender': gender,
      'birthday': age,
      'avatar': avatar
    };
  }

  bool _validate() {
    return name != null
        && gender != null
        && age != null
        && avatar != null;
  }
}