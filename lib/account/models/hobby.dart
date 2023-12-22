class UserHobby {
  const UserHobby({
    required this.code,
    required this.displayName,
    this.emoji
  });
  final String code;
  final String displayName;
  final String? emoji;

  factory UserHobby.fromJson(Map<String, dynamic> json) {
    return UserHobby(code: json['code'], displayName: json['name'], emoji: json['icon']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'code': code,
    'name': displayName,
    'icon': emoji
  };
}