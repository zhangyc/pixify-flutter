class DuoSnapTask {
  int? id;
  int? userId;
  int? targetUserId;
  int? modelId;
  String? sourcePhotoUrl;
  String? targetPhotoUrl;
  int? status;
  String? failMsg;
  int? times;
  String? userAvatar;
  String? targetUserAvatar;
  String? targetUserNickname;
  int? targetUserGender;
  String? scene;
  DuoSnapTask(
      {this.id,
        this.userId,
        this.targetUserId,
        this.modelId,
        this.sourcePhotoUrl,
        this.targetPhotoUrl,
        this.status,
        this.failMsg,
        this.times,
        this.userAvatar,
        this.targetUserAvatar,
        this.targetUserGender,
        this.scene
      });

  DuoSnapTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    targetUserId = json['targetUserId'];
    modelId = json['modelId'];
    sourcePhotoUrl = json['sourcePhotoUrl'];
    targetPhotoUrl = json['targetPhotoUrl'];
    status = json['status'];
    failMsg = json['failMsg'];
    times = json['times'];
    userAvatar = json['userAvatar'];
    targetUserAvatar = json['targetUserAvatar'];
    targetUserNickname = json['targetUserNickname'];
    targetUserGender = json['targetUserGender'];
    scene = json['scene'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['targetUserId'] = this.targetUserId;
    data['modelId'] = this.modelId;
    data['sourcePhotoUrl'] = this.sourcePhotoUrl;
    data['targetPhotoUrl'] = this.targetPhotoUrl;
    data['status'] = this.status;
    data['failMsg'] = this.failMsg;
    data['times'] = this.times;
    data['userAvatar'] = this.userAvatar;
    data['targetUserAvatar'] = this.targetUserAvatar;
    data['targetUserNickname'] = this.targetUserNickname;
    data['targetUserGender'] = this.targetUserGender;
    data['scene'] = this.scene;
    return data;
  }
}