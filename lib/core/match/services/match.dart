import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sona/account/models/gender.dart';

import '../util/http_util.dart';

Future<HttpResult> fetchMatchPeople({
  required Position position,
  Gender? gender,
  RangeValues? range
}) {
  return post(
    '/user/match-v2',
    data: {
      'gender': gender?.index,
      'minAge': range?.start.toInt(),
      'maxAge': range?.end.toInt(),
      'longitude': position.longitude,
      'latitude': position.latitude,
      "pageSize":5, // 每页数量,
    }
  );
}

Future<HttpResult> matchAction({
  required int userId,
  required MatchAction action
}) {
  return post(
      '/user/update-relation',
      data: {
        'userId': userId,
        'relationType': action.value
      }
  );
}

Future<String?> getLikeActivity({
  required int userId,
}) {
  return post(
    '/user/find-like-reason',
    data: {'id': userId}
  ).then<String>((resp) => resp.statusCode == 0 ? resp.data['likeReason'] : '')
  .then<String?>((String value) => value.isEmpty ? null : value)
  .catchError((e) => null);
}

enum MatchAction {
  skip(1),
  like(2),
  arrow(3),
  block(5),
  check(6),
  unmatch(8);

  const MatchAction(this.value);
  final int value;
}
