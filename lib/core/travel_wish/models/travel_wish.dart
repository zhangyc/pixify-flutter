class TravelWish {
  TravelWish({
    required this.id,
    required this.userId,
    required this.when,
    required this.countryId,
    required this.countryName,
    this.countryFlag,
    this.countryPhoto,
    this.cityIds = const <int>[],
    this.cityNames = const <String>[],
    this.activityIds = const <int>[],
    this.activityNames = const <String>[]
  });
  final int id;
  final int userId;
  final String when;
  final int countryId;
  final String countryName;
  final String? countryFlag;
  final String? countryPhoto;
  final List<int> cityIds;
  final List<String> cityNames;
  final List<int> activityIds;
  final List<String> activityNames;

  factory TravelWish.fromJson(Map<String, dynamic> json) {
    final cityIdsStr =  json['cityId'] as String?;
    final cityNamesStr = json['cityName'] as String?;
    final activities = json['activity'] as List?;
    List<int> cityIds;
    List<String> cityNames;
    List<int> activityIds;
    List<String> activityNames;
    if (cityIdsStr != null && cityIdsStr.isNotEmpty) {
      cityIds = cityIdsStr.split('#').map(int.parse).toList();
    } else {
      cityIds = <int>[];
    }
    if (cityNamesStr != null && cityNamesStr.isNotEmpty) {
      cityNames = cityNamesStr.split('#').toList();
    } else {
      cityNames = <String>[];
    }
    if (activities != null && activities.isNotEmpty) {
      activityIds = activities.map<int>((a) => a['id'] as int).toList();
      activityNames = activities.map<String>((a) => a['title'] as String).toList();
    } else {
      activityIds = <int>[];
      activityNames = <String>[];
    }
    return TravelWish(
      id: json['id'],
      userId: json['userId'],
      when: json['timeTypeName'],
      countryId: json['countryId'],
      countryName: json['countryName'],
      countryFlag: json['countryFlag'],
      countryPhoto: json['pic'],
      cityIds: cityIds,
      cityNames: cityNames,
      activityIds: activityIds,
      activityNames: activityNames
    );
  }
}