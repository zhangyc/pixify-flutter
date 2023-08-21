class UserModel {
  int? birthday;
  int? gender;
  int? chatStyleId;
  String? nickname;
  String? description;
  int? id;
  String? avatar;
  List<String>? images;

  UserModel(
      {this.birthday,
        this.gender,
        this.chatStyleId,
        this.nickname,
        this.description,
        this.id,
        this.avatar,
        this.images});

  UserModel.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    gender = json['gender'];
    chatStyleId = json['chatStyleId'];
    nickname = json['nickname'];
    description = json['description'];
    id = json['id'];
    avatar = json['avatar'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['chatStyleId'] = this.chatStyleId;
    data['nickname'] = this.nickname;
    data['description'] = this.description;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['images'] = this.images;
    return data;
  }
}