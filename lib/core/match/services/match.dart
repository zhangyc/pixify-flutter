import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sona/account/models/gender.dart';

import '../../../utils/providers/dio.dart';

Future<Response> fetchMatchPeople({
  required Dio httpClient,
  required Position position,
  Gender? gender,
  RangeValues? range
}) async {
  return httpClient.post(
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
  arrow(3);

  const MatchAction(this.value);
  final int value;
}
