class UserHobby {
  const UserHobby({required this.code, required this.displayName});
  final String code;
  final String displayName;

  factory UserHobby.fromJson(Map<String, dynamic> json) {
    return UserHobby(code: json['code'], displayName: json['name']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'code': code,
    'name': displayName
  };
}