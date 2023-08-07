import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_status.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

class TencentImService {

  Future<void> init() async {
    // 1. 从即时通信 IM 控制台获取应用 SDKAppID。
    int sdkAppID = 0;
    // 2. 添加 V2TimSDKListener 的事件监听器，sdkListener 是 V2TimSDKListener 的实现类
    V2TimSDKListener sdkListener = V2TimSDKListener(
      onConnectFailed: _onConnectFailed,
      onConnectSuccess: _onConnectSuccess,
      onConnecting: _onConnecting,
      onKickedOffline: _onKickedOffline,
      onSelfInfoUpdated: _onSelfInfoUpdated,
      onUserSigExpired: _onUserSigExpired,
      onUserStatusChanged: _onUserStatusChanged,
    );
    // 3.初始化SDK
    final initSDKRes = await TencentImSDKPlugin.v2TIMManager.initSDK(
      sdkAppID: sdkAppID, // SDKAppID
      loglevel: LogLevelEnum.V2TIM_LOG_DEBUG, // 日志登记等级
      listener: sdkListener, // 事件监听器
    );
    if (initSDKRes.code == 0) {
      // 初始化成功
    }
  }

  Future login() async {
    String userID = "your user id";
    String userSig = "userSig from your server";
    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager.login(userID: userID, userSig: userSig);
    if (res.code == 0) {
      // 登录成功逻辑
    } else {
      // 登录失败逻辑
    }
  }

  // 在用户登陆成功之后可调用
  // 调用getLoginUser获取登录成功的用户 UserID
  Future<String?> _getLoggedInUser() async {
    V2TimValueCallback<String> getLoginUserRes = await TencentImSDKPlugin.v2TIMManager.getLoginUser();
    if (getLoginUserRes.code == 0) {
      //获取成功
      return getLoginUserRes.data; // getLoginUserRes.data为查询到的登录用户的UserID
    }
    return null;
  }

  Future<V2TimCallback> unInit() {
    return TencentImSDKPlugin.v2TIMManager.unInitSDK();
  }

  void _onConnectFailed(int code, String error) {

  }

  void _onConnectSuccess() {

  }

  void _onConnecting() {

  }

  void _onKickedOffline() {

  }

  // 登录用户的资料发生了更新
  // info登录用户的资料
  void _onSelfInfoUpdated(V2TimUserFullInfo info) {

  }

  void _onUserSigExpired() {

  }

  // 用户状态变更通知
  // userStatusList 用户状态变化的用户列表
  // 收到通知的情况：订阅过的用户发生了状态变更（包括在线状态和自定义状态），会触发该回调
  // 在 IM 控制台打开了好友状态通知开关，即使未主动订阅，当好友状态发生变更时，也会触发该回调
  // 同一个账号多设备登录，当其中一台设备修改了自定义状态，所有设备都会收到该回调
  void _onUserStatusChanged(List<V2TimUserStatus> userStatusList) {

  }
}