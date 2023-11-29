class TravelTimeframeOptions {
  const TravelTimeframeOptions({
    required this.value,
    required this.name
  });

  factory TravelTimeframeOptions.fromJson(Map<String, dynamic> json) {
    return TravelTimeframeOptions(
      value: json['code'],
      name: json['name']
    );
  }

  final String value;
  final String name;
}