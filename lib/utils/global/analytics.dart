part of './global.dart';


class SonaAnalytics {
  SonaAnalytics._();

  static final _facebook = FacebookAppEvents();

  static init() async {
    final p = await Permission.appTrackingTransparency.request();
    if (p.isGranted) {
      _facebook.setAdvertiserTracking(enabled: true);
    } else {
      _facebook.setAdvertiserTracking(enabled: false);
    }
  }

  static setUserId() {
    final id = userId;
    if (id == null) return;
    _facebook.setUserID(id.toString());
    FirebaseAnalytics.instance.setUserId(id: id.toString());
  }

  static log(String name, [Map<String, Object>? parameters]) {
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