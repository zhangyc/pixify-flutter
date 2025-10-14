import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:sona/account/models/my_profile.dart';
import 'src/firebase_chat_core.dart';

/// IM管理器，提供简单的接口来处理常见的IM操作
class IMManager {
  IMManager._();
  static final instance = IMManager._();

  final _core = FirebaseChatCore.instance;

  /// 发送文本消息
  Future<void> sendTextMessage(
      String roomId, String text, MyProfile currentUser) async {
    final textMessage = types.PartialText(text: text);
    _core.sendMessage(textMessage, roomId, currentUser);
  }

  /// 发送文件消息
  Future<void> sendFileMessage(
    String roomId,
    String uri,
    MyProfile currentUser, {
    String? name,
    int? size,
    String? mimeType,
  }) async {
    final file = types.PartialFile(
      name: name ?? 'file',
      size: size ?? 0,
      uri: uri,
      mimeType: mimeType,
    );
    _core.sendMessage(file, roomId, currentUser);
  }

  /// 发送图片消息
  Future<void> sendImageMessage(
    String roomId,
    String uri,
    MyProfile currentUser, {
    String? name,
    int? size,
    double? width,
    double? height,
  }) async {
    final image = types.PartialImage(
      name: name ?? 'image',
      size: size ?? 0,
      uri: uri,
      width: width,
      height: height,
    );
    _core.sendMessage(image, roomId, currentUser);
  }

  /// 创建或获取与指定用户的私聊房间
  Future<types.Room> createOrGetDirectRoom(
      types.User otherUser, MyProfile currentUser) async {
    return _core.createRoom(otherUser, currentUser: currentUser);
  }

  /// 获取房间列表流
  Stream<List<types.Room>> getRoomListStream(MyProfile currentUser) {
    return _core.rooms(currentUser, orderByUpdatedAt: true);
  }

  /// 获取指定房间的消息列表流
  Stream<List<types.Message>> getMessageListStream(types.Room room,
      {int? limit}) {
    return _core.messages(room, limit: limit);
  }

  /// 获取单个房间的流
  Stream<types.Room> getRoomStream(String roomId, MyProfile currentUser) {
    return _core.room(roomId, currentUser);
  }

  /// 删除消息
  Future<void> deleteMessage(String roomId, String messageId) async {
    await _core.deleteMessage(roomId, messageId);
  }

  /// 删除房间
  Future<void> deleteRoom(String roomId) async {
    await _core.deleteRoom(roomId);
  }

  /// 更新消息
  Future<void> updateMessage(
      types.Message message, String roomId, MyProfile currentUser) async {
    _core.updateMessage(message, roomId, currentUser);
  }

  /// 更新房间信息
  Future<void> updateRoom(types.Room room, MyProfile currentUser) async {
    _core.updateRoom(room, currentUser);
  }

  /// 创建群聊房间
  Future<types.Room> createGroupRoom({
    required String name,
    required List<types.User> users,
    required MyProfile currentUser,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) async {
    return _core.createGroupRoom(
      name: name,
      users: users,
      currentUser: currentUser,
      imageUrl: imageUrl,
      metadata: metadata,
    );
  }

  /// 获取用户列表流（除了当前用户）
  Stream<List<types.User>> getUserListStream(MyProfile currentUser) {
    return _core.users(currentUser);
  }
}
