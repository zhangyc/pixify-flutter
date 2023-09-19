import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/user_info.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/picker/gender.dart';

import '../../common/widgets/button/colored.dart';
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
                SizedBox(height: 56),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 26),
                    child: Text('Bio', style: Theme.of(context).textTheme.titleMedium),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onBioEdit,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 300),
                    margin: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        ref.watch(asyncMyProfileProvider).value!.bio ?? 'You can just write a little,\nthen use Sona to help optimize',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _sonaWritesBio,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text('Sona Impression', style: Theme.of(context).textTheme.bodySmall),
                    ),
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
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 30),
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

  Future onBioEdit() async {
    final controller = TextEditingController(text: ref.read(asyncMyProfileProvider).value!.bio ?? '');
    final text = await showTextFieldDialog(
      context: context,
      controller: controller,
      hint: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async {
              final resp = await callSona(
                httpClient: ref.read(dioProvider),
                type: CallSonaType.BIO,
                input: controller.text
              );
              if (resp.data['txt'] != null) controller.text = resp.data['txt'];
            },
            child: Text('Ask Sona to Optimize', style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).primaryColor
            ))
          ),
          SizedBox(width: 40),
        ],
      ),
      maxLength: 256,
      saveFlex: 3,
      cancelFlex: 2
    );
    if (text != null && text.trim().isNotEmpty) {
      await callSona(
        httpClient: ref.read(dioProvider),
        type: CallSonaType.BIO,
        input: text
      );
      await ref.read(asyncMyProfileProvider.notifier).refresh();
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
    print(bytes.length);
    final res=await compressList(bytes);
    print(res.length);
    if(res.isEmpty){
      throw Exception('Handle fail');
    }
    final dio = ref.read(dioProvider);
    // todo 通过provider
    await addPhoto(httpClient: dio, bytes: res, filename: file.name);
    ref.read(asyncMyProfileProvider.notifier).refresh();
  }

  Future _onRemovePhoto(int photoId) async {
    await removePhoto(httpClient: ref.read(dioProvider), photoId: photoId);
    ref.read(asyncMyProfileProvider.notifier).refresh();
  }
  // 4. compress Uint8List and get another Uint8List.
  Future<Uint8List> compressList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 80,
      rotate: 0,
    );
    return result;
  }
}