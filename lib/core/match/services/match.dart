import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/utils/global/global.dart';

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
      'latitude': position.latitude
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

enum MatchAction {
  skip(1),
  like(2),
  arrow(3),
  block(5),
  check(6);

  const MatchAction(this.value);
  final int value;
}
