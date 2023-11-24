class TravelWish {
  TravelWish({
    required this.id,
    required this.userId,
    required this.countryId,
    this.countryFlag,
    this.countryPhoto,
    this.cityIds = const <int>[],
    this.activityIds = const <int>[],
    this.activityNames = const <String>[]
  });
  final int id;
  final int userId;
  final int countryId;
  final String? countryFlag;
  final String? countryPhoto;
  final List<int> cityIds;
  final List<int> activityIds;
  final List<String> activityNames;

  factory TravelWish.fromJson(Map<String, dynamic> json) {
    final cityIdsStr =  json['cityId'] as String?;
    final activityIdsStr = json['activityIds'] as String?;
    final activityNamesStr = json['activityNames'] as String?;
    List<int> cityIds;
    List<int> activityIds;
    List<String> activityNames;
    if (cityIdsStr != null && cityIdsStr.isNotEmpty) {
      cityIds = cityIdsStr.split('#').map(int.parse).toList();
    } else {
      cityIds = <int>[];
    }
    if (activityIdsStr != null && activityIdsStr.isNotEmpty) {
      activityIds = activityIdsStr.split('#').map(int.parse).toList();
    } else {
      activityIds = <int>[];
    }
    if (activityNamesStr != null && activityNamesStr.isNotEmpty) {
      activityNames = activityNamesStr.split('#').toList();
    } else {
      activityNames = <String>[];
    }
    return TravelWish(
      id: json['id'],
      userId: json['userId'],
      countryId: json['countryId'],
      countryFlag: json['countryFlag'],
      countryPhoto: json['pic'],
      cityIds: cityIds,
      activityIds: activityIds,
      activityNames: activityNames
    );
  }
}