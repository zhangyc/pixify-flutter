class User {
  User({
    required this.phone,
    required this.name
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(phone: json['phone'], name: json['name']);
  }

  final String phone;
  final String name;

  toJson() => <String, dynamic>{
    'phone': phone,
    'name': name
  };
}