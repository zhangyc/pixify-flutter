class DuoSnapTask {
  int? id;
  int? userId;
  int? targetUserId;
  String? model;
  String? sourcePhotoUrl;
  String? targetPhotoUrl;
  int? status;
  String? failMsg;
  int? times;
  String? userAvatar;
  DuoSnapTask(
      {this.id,
        this.userId,
        this.targetUserId,
        this.model,
        this.sourcePhotoUrl,
        this.targetPhotoUrl,
        this.status,
        this.failMsg,
        this.times,
        this.userAvatar
      });

  DuoSnapTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    targetUserId = json['targetUserId'];
    model = json['model'];
    sourcePhotoUrl = json['sourcePhotoUrl'];
    targetPhotoUrl = json['targetPhotoUrl'];
    status = json['status'];
    failMsg = json['failMsg'];
    times = json['times'];
    userAvatar = json['userAvatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['targetUserId'] = this.targetUserId;
    data['model'] = this.model;
    data['sourcePhotoUrl'] = this.sourcePhotoUrl;
    data['targetPhotoUrl'] = this.targetPhotoUrl;
    data['status'] = this.status;
    data['failMsg'] = this.failMsg;
    data['times'] = this.times;
    data['userAvatar'] = this.userAvatar;

    return data;
  }
}