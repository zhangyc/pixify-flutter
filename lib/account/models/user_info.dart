class UserInfo {
  const UserInfo({
    required this.name,
    required this.gender,
    required this.age,
    required this.avatar
  });

  final String? name;
  final String? gender;
  final String? age;
  final String? avatar;

  static const empty = UserInfo(name: '', gender: '', age: '', avatar: '');

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        name: json['name'],
        gender: json['gender'],
        age: json['age'],
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
    String? gender,
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
      'name': name,
      'gender': gender,
      'age': age,
      'avatar': avatar
    };
  }
}