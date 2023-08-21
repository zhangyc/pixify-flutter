class MyInfo {
  const MyInfo({
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

  static const empty = MyInfo(name: '', gender: 1, age: '', avatar: '');

  factory MyInfo.fromJson(Map<String, dynamic> json) {
    return MyInfo(
        name: json['nickname'],
        gender: json['gender'],
        age: json['birthday'],
        avatar: json['avatar']
    );
  }

  MyInfo copyWith(MyInfo info) {
    return MyInfo(
        name: info.name ?? name,
        gender: info.gender ?? gender,
        age: info.age ?? age,
        avatar: info.avatar ?? avatar
    );
  }

  MyInfo copyWithProperties({
    String? name,
    int? gender,
    String? age,
    String? avatar
  }) {
    return MyInfo(
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