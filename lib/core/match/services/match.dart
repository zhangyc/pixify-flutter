import 'package:dio/dio.dart';

Future<Response> fetchMatchPeople({
  required Dio httpClient,
  required int page,
  int pageSize = 50
}) async {
  return httpClient.post(
    '/user/match',
    data: {
      'page': page,
      'pageSize': pageSize
    }
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
  like(1),
  skip(2),
  arrow(3);

  const MatchAction(this.value);
  final int value;
}
