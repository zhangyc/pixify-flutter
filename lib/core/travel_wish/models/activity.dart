class PopularTravelActivity {
  PopularTravelActivity({
    required this.id,
    required this.displayName,
  });
  final int id;
  final String displayName;

  factory PopularTravelActivity.fromJson(Map<String, dynamic> json) {
    return PopularTravelActivity(id: json['id'], displayName: json['title']);
  }
}