import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/tag/hobby.dart';
import 'package:sona/utils/dialog/crop_image.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/dialog/multi_line_text_field/multi_line_text_field.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/picker/gender.dart';
import 'package:sona/utils/picker/interest.dart';

import '../../generated/l10n.dart';
import '../../utils/face_detection/detection.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  late MyProfile _profile;

  @override
  void initState() {
    SonaAnalytics.log('my_profile_edit');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _profile = ref.watch(myProfileProvider)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SonaIcon(icon: SonaIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.of(context).buttonEditProfile),
        centerTitle: true,
        actions: [
          UnconstrainedBox(
              child: FittedBox(
                child: TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(userId: _profile.id,relation: Relation.self,))),
                    style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size.zero)
                    ),
                    child: Text(S.of(context).buttonPreview)
                ),
              ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: Text(S.of(context).photos, style: Theme.of(context).textTheme.titleMedium),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(S.of(context).morePhotosBenefit, style: Theme.of(context).textTheme.labelMedium),
                ),
                SizedBox(height: 16),
              ],
            )
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3/4
              ),
              delegate: SliverChildBuilderDelegate(
                _photoBuilder,
                childCount: _profile.photos.length + 1
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).bio, style: Theme.of(context).textTheme.titleMedium),
                      GestureDetector(
                        onTap: onBioEdit,
                        child: Text(S.of(context).buttonEdit, style: Theme.of(context).textTheme.titleSmall)
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (_profile.bio != null && _profile.bio!.isNotEmpty) Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F3F3),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text(_profile.bio!),
                  ) else GestureDetector(
                    onTap: onBioEdit,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Color(0xFFF6F3F3),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text(
                        S.of(context).showYourPersonality,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).hintColor
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).interests, style: Theme.of(context).textTheme.titleMedium),
                      GestureDetector(
                        onTap: _onEditInterests,
                        child: Text(S.of(context).buttonEdit, style: Theme.of(context).textTheme.titleSmall)
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (_profile.interests.isNotEmpty) Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      ..._profile.interests.map((h) => HobbyTag(
                        value: h.code,
                        displayName: h.displayName,
                        selected: true,
                      ))
                    ]
                  ) else GestureDetector(
                    onTap: _onEditInterests,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text(
                          S.of(context).findingFolksWhoShareYourInterests,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).hintColor
                        ),
                      ),
                    ),
                  )
                ],
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
        child: Container(
          // width: 96,
          // height: 144,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xFFB7B7B7)),
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFF6F3F3)
          ),
          child: Icon(Icons.add, size: 32, color: Color(0xFFB7B7B7))
        )
      );
    } else {
      final photo = _profile.photos[index];
      child = CachedNetworkImage(imageUrl: photo.url, fit: BoxFit.cover, width: 96, height: 144, alignment: Alignment.center,);
    }
    final actions = <String, String>{};
    if (_profile.photos.length > 1) {
      if (index != 0) {
        actions[S.of(context).setDefault] = 'set_default';
      }
      actions[S.of(context).buttonDelete] = 'delete';
    }
    return GestureDetector(
      onLongPress: () => _showPhotoActions(index, actions),
      onTap: _seeMyProfile,
      child: Container(
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE8E6E6), width: 1),
          borderRadius: BorderRadius.circular(20)
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }

  void _seeMyProfile() {
    SonaAnalytics.log('my_profile_preview');
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => UserProfileScreen(
          userId: ref.read(myProfileProvider)!.toUser().id,
          relation: Relation.self,
        )
    ));
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
      MaterialPageRoute(
        builder: (_) => MultiLineTextFieldScreen(
          title: S.of(context).bio,
          maxLength: 360,
          initialValue: _profile.bio,
          onSave: (String text) async {
            await ref.read(myProfileProvider.notifier).updateFields(bio: text);
            Navigator.pop(context);
            SonaAnalytics.log('my_profile_bio_edit');
          }
        )
      )
    );
  }

  void _showPhotoActions(int index, Map<String, String> actions) async {
    if (actions.isEmpty) return;
    final photo = _profile.photos[index];
    final action = await showActionButtons(context: context, options: actions);
    if (action == 'delete') {
      _onRemovePhoto(photo.id);
    } else if (action == 'set_default') {
      final photos = ref.read(myProfileProvider)!.photos;
      photos..remove(photo)..insert(0, photo);
      final data = photos.asMap().entries.map<Map<String, dynamic>>((entry) => {'id': entry.value.id, 'sort': entry.key}).toList();
      await updatePhotoSorts(data: data);
      ref.read(myProfileProvider.notifier).refresh();
    }
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
      Fluttertoast.showToast(msg: 'GIF is not allowed');
      return;
    }
    Uint8List? bytes = await file.readAsBytes();
    bytes = await cropImage(bytes);
    if (bytes == null) return;
    await addPhoto(bytes: bytes, filename: file.name);
    ref.read(myProfileProvider.notifier).refresh();
    SonaAnalytics.log('my_profile_photo_add');
  }

  Future _onRemovePhoto(int photoId) async {
    await removePhoto(photoId: photoId);
    ref.read(myProfileProvider.notifier).refresh();
  }

  void _showImpressionDesc() {
    showInfo(
        context: context,
        content: 'Sona will notice changes to your bio and interests, and form impressions of you based on them.\nSona\'s impression tags update every Monday at 1am GMT, as long as your profile information has changed.\nThere may be delays for different users.'
    );
  }
}