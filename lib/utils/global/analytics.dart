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

  static Map<String, Object> _getCommonParams() {
    return {
      'platform': Platform.isIOS ? 'ios' : 'android',
      'os_version': Platform.operatingSystemVersion,
      'timestamp': DateTime.now().toIso8601String(),
      if (userId != null) 'user_id': userId!
    };
  }

  static log(String name, [Map<String, Object>? parameters]) {
    if (kDebugMode) return;
    try {
      // 合并通用参数
      final params = {..._getCommonParams(), ...?parameters};

      // Firebase 打点
      FirebaseAnalytics.instance.logEvent(name: name, parameters: params);

      // Facebook 打点
      _facebook.logEvent(
          name: name,
          parameters:
              params.map((key, value) => MapEntry(key, value.toString())));
    } catch (e) {
      //
    }
  }

  static logFacebookEvent(String name, [Map<String, dynamic>? parameters]) {
    if (kDebugMode) return;
    try {
      final params = {..._getCommonParams(), ...?parameters};
      _facebook.logEvent(name: name, parameters: params);
    } catch (e) {
      //
    }
  }
}
