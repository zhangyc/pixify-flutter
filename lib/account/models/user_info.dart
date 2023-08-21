class MyInfo {
  const MyInfo({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.avatar,
    this.bio,
    this.chatStyleId,
    this.photos = const <String>[]
  });

  final int id;
  final String? name;
  final int? gender;
  final String? age;
  final String? avatar;
  final String? bio;
  final int? chatStyleId;
  final List<String> photos;

  bool get completed => _validate();

  static const empty = MyInfo(id: 0, name: '', gender: 1, age: '', avatar: '');

  factory MyInfo.fromJson(Map<String, dynamic> json) {
    return MyInfo(
      id: json['id'],
      name: json['nickname'],
      gender: json['gender'],
      age: json['birthday'],
      avatar: json['avatar'],
      bio: json['description'],
      photos: json['images'] != null ? (json['images'] as List).map<String>((photo) => photo['attachmentUrl']).toList() : []
    );
  }

  MyInfo copyWith(MyInfo info) {
    return MyInfo(
      id: info.id,
      name: info.name ?? name,
      gender: info.gender ?? gender,
      age: info.age ?? age,
      avatar: info.avatar ?? avatar,
      bio: info.bio ?? bio
    );
  }

  MyInfo copyWithProperties({
    String? name,
    int? gender,
    String? age,
    String? avatar,
    String? bio
  }) {
    return MyInfo(
      id: id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio
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