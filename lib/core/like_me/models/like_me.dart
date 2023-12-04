import 'package:sona/common/models/base_user.dart';

mixin LikeMe on BaseUser {
  late final List<String>? tags;
  bool get isNew => tags != null && tags!.contains('New');
  String? get displayTag => tags?.firstOrNull;
  late final String hang;
}