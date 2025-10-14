import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sona/utils/global/global.dart';

import '../../../utils/im/im_manager.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  // 控制发送按钮状态
  bool get _canSend => !_isAttachmentUploading;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    // 标记消息已读
    if (profile != null) {
      IMManager.instance.updateMessage(
        types.TextMessage(
          author: types.User(id: profile!.id.toString()),
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: '',
          status: types.Status.seen,
        ),
        widget.room.id,
        profile!,
      );
    }
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleFileSelection() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowCompression: true, // 允许压缩
        allowMultiple: false, // 单文件
      );

      if (result == null || result.files.single.path == null) return;

      _setAttachmentUploading(true);
      final file = File(result.files.single.path!);
      final size = await file.length();

      // 检查文件大小限制 (20MB)
      if (size > 20 * 1024 * 1024) {
        _showError('File size cannot exceed 20MB');
        return;
      }

      // 生成唯一文件名
      final ext = result.files.single.extension ?? '';
      final name = '${DateTime.now().millisecondsSinceEpoch}.$ext';

      // 上传到指定目录
      final reference = FirebaseStorage.instance
          .ref()
          .child('chat')
          .child(widget.room.id)
          .child(name);

      // 上传文件
      final uploadTask = reference.putFile(
        file,
        SettableMetadata(
          contentType: lookupMimeType(result.files.single.path!),
          customMetadata: {
            'uploadedBy': profile?.id.toString() ?? 'unknown',
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      // 监听上传进度
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        debugPrint('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
      });

      // 等待上传完成
      await uploadTask;
      final uri = await reference.getDownloadURL();

      // 发送文件消息
      await IMManager.instance.sendFileMessage(
        widget.room.id,
        uri,
        profile!,
        name: result.files.single.name,
        size: size,
        mimeType: lookupMimeType(result.files.single.path!),
      );
    } catch (e, stackTrace) {
      debugPrint('File upload error: $e');
      debugPrint('Stack trace: $stackTrace');
      _showError('Failed to upload file: ${e.toString()}');
    } finally {
      _setAttachmentUploading(false);
    }
  }

  Future<void> _handleImageSelection() async {
    try {
      final result = await ImagePicker().pickImage(
        imageQuality: 70,
        maxWidth: 1440,
        source: ImageSource.gallery,
      );

      if (result == null) return;

      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = await file.length();

      // 检查文件大小限制 (10MB)
      if (size > 10 * 1024 * 1024) {
        _showError('Image size cannot exceed 10MB');
        return;
      }

      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      // 生成唯一文件名
      final ext = result.name.split('.').last;
      final name = '${DateTime.now().millisecondsSinceEpoch}.$ext';

      // 上传到指定目录
      final reference = FirebaseStorage.instance
          .ref()
          .child('chat')
          .child(widget.room.id)
          .child('images')
          .child(name);

      // 上传图片
      final uploadTask = reference.putFile(
        file,
        SettableMetadata(
          contentType: 'image/$ext',
          customMetadata: {
            'uploadedBy': profile?.id.toString() ?? 'unknown',
            'uploadedAt': DateTime.now().toIso8601String(),
            'width': image.width.toString(),
            'height': image.height.toString(),
          },
        ),
      );

      // 监听上传进度
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        debugPrint('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
      });

      // 等待上传完成
      await uploadTask;
      final uri = await reference.getDownloadURL();

      // 发送图片消息
      await IMManager.instance.sendImageMessage(
        widget.room.id,
        uri,
        profile!,
        name: name,
        size: size,
        width: image.width.toDouble(),
        height: image.height.toDouble(),
      );
    } catch (e, stackTrace) {
      debugPrint('Image upload error: $e');
      debugPrint('Stack trace: $stackTrace');
      _showError('Failed to upload image: ${e.toString()}');
    } finally {
      _setAttachmentUploading(false);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          IMManager.instance
              .updateMessage(updatedMessage, widget.room.id, profile!);

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          IMManager.instance
              .updateMessage(updatedMessage, widget.room.id, profile!);
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    IMManager.instance.updateMessage(updatedMessage, widget.room.id, profile!);
  }

  void _handleSendPressed(types.PartialText message) {
    IMManager.instance.sendTextMessage(widget.room.id, message.text, profile!);
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: widget.room.imageUrl != null
                    ? NetworkImage(widget.room.imageUrl!)
                    : null,
                child: widget.room.imageUrl == null
                    ? Text(widget.room.name?[0].toUpperCase() ?? '?')
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: widget.room.name?[0].toUpperCase() ?? '?',
                            style: const TextStyle(fontSize: 16, height: 2.0)),
                        if (widget.room.type == types.RoomType.group)
                          TextSpan(
                              text: '${widget.room.users.length} members',
                              style: const TextStyle(fontSize: 12)),
                      ]),
                    ),
                    Text(
                      widget.room.name ?? 'Chat',
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (widget.room.type == types.RoomType.group)
                      Text(
                        '${widget.room.users.length} members',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // TODO: 显示聊天室设置菜单
              },
            ),
          ],
        ),
        body: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: IMManager.instance.getRoomStream(widget.room.id, profile!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return StreamBuilder<List<types.Message>>(
              initialData: const [],
              stream: IMManager.instance.getMessageListStream(snapshot.data!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                return Chat(
                  theme: DefaultChatTheme(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    primaryColor: Theme.of(context).primaryColor,
                    secondaryColor: Theme.of(context).cardColor,
                    userAvatarNameColors: [
                      Theme.of(context).primaryColor,
                    ],
                  ),
                  isAttachmentUploading: _isAttachmentUploading,
                  messages: snapshot.data ?? [],
                  onAttachmentPressed:
                      _canSend ? _handleAtachmentPressed : null,
                  onMessageTap: _handleMessageTap,
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  onSendPressed: _handleSendPressed,
                  showUserAvatars: true,
                  showUserNames: widget.room.type == types.RoomType.group,
                  user: types.User(
                    id: profile!.id.toString(),
                  ),
                );
              },
            );
          },
        ),
      );
}
