class SdTemplate {
  String? vipLevel;
  String? name;
  int? id;
  String? url;
  bool? hasNew;

  SdTemplate({this.vipLevel, this.name, this.id, this.url, this.hasNew});

  SdTemplate.fromJson(Map<String, dynamic> json) {
    vipLevel = json['vipLevel'];
    name = json['name'];
    id = json['id'];
    url = json['url'];
    hasNew = json['hasNew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vipLevel'] = this.vipLevel;
    data['name'] = this.name;
    data['id'] = this.id;
    data['url'] = this.url;
    data['hasNew'] = this.hasNew;
    return data;
  }
}