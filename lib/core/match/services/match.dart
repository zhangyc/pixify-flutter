import 'package:dio/dio.dart';

Future<Response> fetchMatchPeople({
  required Dio httpClient,
}) async {
  return httpClient.post(
    '/user/match'
  );
}

Future<Response> matchAction({
  required Dio httpClient,
  required int userId,
  required MatchAction action
}) async {
  return httpClient.post(
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
