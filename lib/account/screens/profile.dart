import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/user_info.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/picker/gender.dart';

import '../../utils/providers/dio.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  late MyProfile _profile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _profile = ref.watch(asyncMyProfileProvider).value!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 16, bottom: 24),
              alignment: Alignment.center,
              child: Text('更多真实照片会增加匹配成功率'),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                _photoBuilder,
                childCount: 9
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 600 / 848
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _showBioEditor,
                  child: Container(
                    height: 108,
                    margin: EdgeInsets.only(left: 16, right: 16, top: 56, bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(ref.watch(asyncMyProfileProvider).value!.bio ?? 'My Bio'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _sonaWritesBio,
                    child: Text('Sona Impression'),
                  ),
                ),
                SizedBox(height: 12)
              ],
            )
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ForwardButton(
                onTap: _showGenderEditor,
                text: '性别 ${_profile.gender!.name}',
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _photoBuilder(BuildContext context, int index) {
    Widget child;
    if (index >= _profile.photos.length) {
      child = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _onAddPhoto();
        },
        child: Center(child: Icon(Icons.add, size: 36))
      );
    } else {
      final photo = _profile.photos[index];
      child = CachedNetworkImage(imageUrl: photo.url, fit: BoxFit.cover);
    }
    return GestureDetector(
      onLongPress: index != 0 ? () => _showPhotoActions(_profile.photos[index]) : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
          borderRadius: BorderRadius.circular(12)
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }

  Future _sonaWritesBio() async {
    final dio = ref.read(dioProvider);
    EasyLoading.show();
    try {
      final resp = await dio.post('/persona/intro/generation');
    } catch (e) {
      //
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future _showBioEditor() async {
    final text = await showTextFieldDialog(
      context: context,
      initialText: ref.read(asyncMyProfileProvider).value!.bio ?? '',
      maxLength: 256
    );
    if (text != null && text.trim().isNotEmpty) {
      await ref.read(asyncMyProfileProvider.notifier).updateInfo(bio: text.trim());
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Future _showGenderEditor() async {
    var gender = await showGenderPicker(
        context: context,
        initialValue: ref.read(asyncMyProfileProvider).value!.gender,
    );
    if (gender != null && gender != _profile.gender) {
      ref.read(asyncMyProfileProvider.notifier).updateInfo(gender: gender);
    }
  }

  void _showPhotoActions(ProfilePhoto photo) async {
    final action = await showRadioFieldDialog(context: context, options: {'Set Default': 'set-default', 'Delete': 'delete'});
    if (action == 'delete') {
      _onRemovePhoto(photo.id);
    } else if (action == 'set-default') {
      final photos = ref.read(asyncMyProfileProvider).value!.photos;
      photos..remove(photo)..insert(0, photo);
      final data = photos.asMap().entries.map<Map<String, dynamic>>((entry) => {'id': entry.value.id, 'sort': entry.key}).toList();
      // todo 通过provider
      await updatePhotoSorts(httpClient: ref.read(dioProvider), data: data);
      ref.read(asyncMyProfileProvider.notifier).refresh();
    }
  }

  Future _onAddPhoto() async {
    final source = await showRadioFieldDialog(context: context, options: {
      'Choose a photo': ImageSource.gallery,
      'Take a photo': ImageSource.camera
    });
    if (source == null) throw Exception('No source');
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    if (file == null) throw Exception('No file');
    final bytes = await file.readAsBytes();
    final dio = ref.read(dioProvider);
    // todo 通过provider
    await addPhoto(httpClient: dio, bytes: bytes, filename: file.name);
    ref.read(asyncMyProfileProvider.notifier).refresh();
  }

  Future _onRemovePhoto(int photoId) async {
    await removePhoto(httpClient: ref.read(dioProvider), photoId: photoId);
    ref.read(asyncMyProfileProvider.notifier).refresh();
  }
}