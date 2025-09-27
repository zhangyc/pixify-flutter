import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/tag/hobby.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/dialog/multi_line_text_field/multi_line_text_field.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/picker/interest.dart';

import '../../generated/l10n.dart';
import '../../utils/image_compress_util.dart';
import '../../utils/toast/flutter_toast.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late MyProfile _profile;
  final Set<int> _uploadingPhotos = <int>{}; // 正在上传的照片索引

  @override
  void initState() {
    SonaAnalytics.log('my_profile_edit');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _profile = ref.watch(myProfileProvider)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          S.of(context).buttonEditProfile,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // 照片管理卡片
            _buildPhotoManagementCard(context),
            const SizedBox(height: 24),
            // 个人简介卡片
            _buildBioCard(context),
            const SizedBox(height: 16),
            // 兴趣标签卡片
            _buildInterestsCard(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // 照片管理卡片
  Widget _buildPhotoManagementCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1C1C1E)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.06)
              : Colors.black.withOpacity(0.06),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            children: [
              Icon(
                Icons.photo_library,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                S.of(context).myPhotos,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 照片网格
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
            children: [
              // 添加照片按钮
              GestureDetector(
                onTap: _onAddPhoto,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF2C2C2E)
                        : const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        color: Theme.of(context).primaryColor,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        S.of(context).addPhoto,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              // 现有照片
              ..._profile.photos.asMap().entries.map((entry) {
                final photoIndex = entry.key;
                final photo = entry.value;
                return _buildPhotoItem(context, photo, photoIndex);
              }),
            ],
          ),
        ],
      ),
    );
  }

  // 单个照片项
  Widget _buildPhotoItem(BuildContext context, dynamic photo, int photoIndex) {
    return Stack(
      children: [
        // 照片
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: photo.url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF2C2C2E)
                    : const Color(0xFFF2F2F7),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF2C2C2E)
                    : const Color(0xFFF2F2F7),
                child: const Icon(Icons.error),
              ),
            ),
          ),
        ),
        // 删除按钮
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _showDeletePhotoDialog(photo),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.8),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ),
        // 上传中遮罩
        if (_uploadingPhotos.contains(photoIndex))
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  // 个人简介卡片
  Widget _buildBioCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1C1C1E)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.06)
              : Colors.black.withOpacity(0.06),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    S.of(context).bio,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onBioEdit,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        S.of(context).buttonEdit,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_profile.bio != null && _profile.bio!.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF2C2C2E)
                    : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _profile.bio!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          else
            GestureDetector(
              onTap: onBioEdit,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2C2C2E)
                      : const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).showYourPersonality,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 兴趣标签卡片
  Widget _buildInterestsCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1C1C1E)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.06)
              : Colors.black.withOpacity(0.06),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.favorite_outline,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    S.of(context).interests,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _onEditInterests,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        S.of(context).buttonEdit,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_profile.interests.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: _profile.interests
                  .map((interest) => HobbyTag(
                        value: interest.code,
                        displayName: interest.displayName,
                        selected: true,
                      ))
                  .toList(),
            )
          else
            GestureDetector(
              onTap: _onEditInterests,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2C2C2E)
                      : const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).findingFolksWhoShareYourInterests,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 删除照片确认对话框
  void _showDeletePhotoDialog(dynamic photo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).deletePhoto),
          content: Text(S.of(context).deletePhotoContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                S.of(context).buttonCancel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _onRemovePhoto(photo.id);
              },
              child: Text(
                S.of(context).buttonDelete,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future _onEditInterests() async {
    final result = await showHobbiesSelector(context: context);
    if (result != null) {
      ref.read(myProfileProvider.notifier).updateFields(interests: result);
      SonaAnalytics.log('my_profile_interests_edit');
    }
  }

  Future onBioEdit() async {
    await Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (_) => MultiLineTextFieldScreen(
                title: S.of(context).bio,
                maxLength: 360,
                initialValue: _profile.bio,
                onSave: (String text) async {
                  await ref
                      .read(myProfileProvider.notifier)
                      .updateFields(bio: text);
                  Navigator.pop(context);
                  SonaAnalytics.log('my_profile_bio_edit');
                })));
  }

  Future _onAddPhoto() async {
    final source = await showActionButtons(context: context, options: {
      S.of(context).photoFromGallery: ImageSource.gallery,
      S.of(context).photoFromCamera: ImageSource.camera
    });
    if (source == null) throw Exception('No source');
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);

    if (file == null) throw Exception('No file');

    ///todo 人脸检测
    //await faceDetection(file.path);

    if (file.name.toLowerCase().endsWith('.gif')) {
      Fluttertoast.showToast(msg: S.of(context).gifNotAllowed);
      return;
    }

    // 确定要上传到的位置（第一个空位）
    final uploadIndex = _profile.photos.length;

    // 开始上传，显示 loading
    setState(() {
      _uploadingPhotos.add(uploadIndex);
    });

    try {
      File? fileResult = await ImageCompressUtil.compressImage(File(file.path));
      Uint8List? bytes = await fileResult?.readAsBytes();
      if (bytes == null) return;

      await addPhoto(bytes: bytes, filename: file.name);
      ref.read(myProfileProvider.notifier).refresh();
      SonaAnalytics.log('my_profile_photo_add');
    } finally {
      // 上传完成，移除 loading
      setState(() {
        _uploadingPhotos.remove(uploadIndex);
      });
    }
  }

  Future _onRemovePhoto(int photoId) async {
    await removePhoto(photoId: photoId);
    ref.read(myProfileProvider.notifier).refresh();
  }
}
