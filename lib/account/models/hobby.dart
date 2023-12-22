class UserHobby {
  const UserHobby({
    required this.code,
    required this.name,
    this.emoji
  });
  final String code;
  final String name;
  final String? emoji;
  String get displayName => '${emoji ?? ''} $name';

  factory UserHobby.fromJson(Map<String, dynamic> json) {
    return UserHobby(
        code: json['code'],
        name: json['name'],
        emoji: json['icon']
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'code': code,
    'name': name,
    'icon': emoji
  };
}