part of './global.dart';


class SonaAnalytics {
  SonaAnalytics._();

  static init() {
    final id = userId;
    if (id == null) return;
    FirebaseAnalytics.instance.setUserId(id: id.toString());
  }

  static log(String name, [Map<String, dynamic>? parameters]) {
    try {
      FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
    } catch(e) {
      //
    }
  }
}