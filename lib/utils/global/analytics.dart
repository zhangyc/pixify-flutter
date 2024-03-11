part of './global.dart';


class SonaAnalytics {
  SonaAnalytics._();

  static final _facebook = FacebookAppEvents();

  static init() {
    final id = userId;
    if (id == null) return;
    FirebaseAnalytics.instance.setUserId(id: id.toString());
  }

  static log(String name, [Map<String, dynamic>? parameters]) {
    if (kDebugMode) return;
    try {
      FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
    } catch(e) {
      //
    }
  }

  static logFacebookEvent(String name, [Map<String, dynamic>? parameters]) {
    _facebook.logEvent(name: name, parameters: parameters);
  }
}