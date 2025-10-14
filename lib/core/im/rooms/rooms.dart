import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/im/im_manager.dart';

import '../chat/chat.dart';
import 'users.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // 创建群聊按钮
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: () {
              _showCreateRoomDialog();
            },
          ),
          // 添加好友按钮
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const UsersPage(),
                ),
              );
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Messages'),
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: profile == null
            ? Stream.value([])
            : IMManager.instance.getRoomListStream(profile!),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No conversations'),
            );
          }

          final rooms = snapshot.data!;
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return _buildRoomItem(room);
            },
          );
        },
      ),
    );
  }

  Widget _buildRoomItem(types.Room room) {
    final lastMessage =
        room.lastMessages?.isNotEmpty == true ? room.lastMessages!.first : null;

    return ListTile(
      leading: _buildAvatar(room),
      title: Text(
        room.name ?? room.users.first.firstName ?? 'Unknown',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: lastMessage != null
          ? Text(
              _getMessagePreview(lastMessage),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(room: room),
          ),
        );
      },
    );
  }

  Widget _buildAvatar(types.Room room) {
    // 群聊显示群头像
    if (room.type == types.RoomType.group) {
      return CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        backgroundImage:
            room.imageUrl != null ? NetworkImage(room.imageUrl!) : null,
        child: room.imageUrl == null
            ? Text(room.name?[0].toUpperCase() ?? 'G',
                style: const TextStyle(color: Colors.white))
            : null,
      );
    }

    // 私聊显示对方头像
    final otherUser = room.users.firstWhere(
      (u) => u.id != profile?.id.toString(),
      orElse: () => room.users.first,
    );

    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage:
          otherUser.imageUrl != null ? NetworkImage(otherUser.imageUrl!) : null,
      child: otherUser.imageUrl == null
          ? Text(otherUser.firstName?[0].toUpperCase() ?? '?',
              style: const TextStyle(color: Colors.white))
          : null,
    );
  }

  String _getMessagePreview(types.Message message) {
    switch (message.type) {
      case types.MessageType.text:
        final textMessage = message as types.TextMessage;
        return textMessage.text;
      case types.MessageType.image:
        return '📷 Image';
      case types.MessageType.file:
        return '📎 File';
      case types.MessageType.audio:
        return '🎵 Audio';
      default:
        return 'Message';
    }
  }

  void _showCreateRoomDialog() {
    final nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Room'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Room Name',
                  hintText: 'Enter room name',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter room name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (formKey.currentState?.validate() != true) return;

              if (profile == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User profile not found')),
                );
                return;
              }

              try {
                debugPrint(
                    'Creating room with name: ${nameController.text.trim()}');
                debugPrint('Current user: ${profile?.toJson()}');

                final room = await IMManager.instance.createGroupRoom(
                  name: nameController.text.trim(),
                  users: [], // 初始只有创建者
                  currentUser: profile!,
                );

                debugPrint('Room created successfully: ${room.toJson()}');

                if (!mounted) return;
                Navigator.pop(context); // 关闭对话框

                // 跳转到聊天页面
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatPage(room: room),
                  ),
                );
              } catch (e, stackTrace) {
                debugPrint('Failed to create room: $e');
                debugPrint('Stack trace: $stackTrace');

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to create room: $e')),
                );
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
