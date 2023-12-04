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
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/utils/dialog/crop_image.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/picker/gender.dart';
import 'package:sona/utils/picker/interest.dart';

import '../../common/widgets/button/colored.dart';
import '../../generated/l10n.dart';

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
    _profile = ref.watch(myProfileProvider)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SonaIcon(icon: SonaIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.current.editProfile),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
                // Row(
                //   children: [
                //     Container(
                //         padding: EdgeInsets.only(left: 16, right: 8, top: 4, bottom: 4),
                //         child: Text('Sona Impression', style: Theme.of(context).textTheme.titleMedium)
                //     ),
                //     GestureDetector(
                //       onTap: _showImpressionDesc,
                //       child: Icon(Icons.info_outline_rounded, size: 12)
                //     )
                //   ],
                // ),
                // SizedBox(height: 4),
                // Visibility(
                //   visible: _profile.impression != null,
                //   child: Container(
                //     margin: EdgeInsets.symmetric(horizontal: 16),
                //     child: Text(
                //       _profile.impression ?? '',
                //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //         color: Theme.of(context).primaryColor
                //       ),
                //     ),
                //   ),
                // ),
                // Visibility(
                //   visible: _profile.impression == null,
                //   child: GestureDetector(
                //     onTap: _showImpressionDesc,
                //     child: Container(
                //       margin: EdgeInsets.symmetric(horizontal: 16),
                //       child: Text(
                //         '👀 How to get a Sona Impression...',
                //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //             color: Color(0xFFE880F1)
                //         ),
                //       ),
                //     ),
                //   ),
                // )
          //     ],
          //   )
          // ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: Row(
                    children: [
                      Text('Photos', style: Theme.of(context).textTheme.titleLarge),
                      // SizedBox(width: 8),
                      // Text('(${_profile.photos.length}/9)', style: Theme.of(context).textTheme.bodySmall)
                    ],
                  )
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('More photos, higher exposure', style: Theme.of(context).textTheme.labelMedium),
                ),
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 144,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: _photoBuilder,
                    separatorBuilder: (_, __) => SizedBox(width: 12),
                    itemCount: _profile.photos.length + (_profile.photos.length < 9 ? 1 : 0)
                  ),
                ),
              ],
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Bio', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 8),
                  ForwardButton(onTap: onBioEdit, text: _profile.bio, placeholder: 'Write sth and let Sona spruce it up')
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
                  Text('Hobbies', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 8),
                  ForwardButton(
                    onTap: _onEditInterests,
                    text: _profile.interests.isNotEmpty ? _profile.interests.join(' , ') : null,
                    placeholder: 'Add your hobbies',
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
                  Text('Gender', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 8),
                  ForwardButton(onTap: _showGenderEditor, text: _profile.gender!.name)
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
          width: 96,
          height: 144,
          child: Icon(Icons.add, size: 36)
        )
      );
    } else if (index == 0) {
      final photo = _profile.photos[index];
      child = Stack(
        children: [
          CachedNetworkImage(imageUrl: photo.url, fit: BoxFit.cover, width: 96, height: 144, alignment: Alignment.center,),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: Text('Avatar', style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white
              )),
            ),
          )
        ],
      );
    } else {
      final photo = _profile.photos[index];
      child = CachedNetworkImage(imageUrl: photo.url, fit: BoxFit.cover, width: 96, height: 144, alignment: Alignment.center,);
    }
    final actions = <String, String>{};
    if (_profile.photos.length > 1) {
      if (index != 0) {
        actions['Set Default'] = 'set_default';
      }
      actions['Delete'] = 'delete';
    }
    return GestureDetector(
      onLongPress: () => _showPhotoActions(index, actions),
      onTap: _seeMyProfile,
      child: Container(
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
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
    Navigator.push(context, MaterialPageRoute(
        builder: (_) => UserProfileScreen(
          userId: ref.read(myProfileProvider)!.toUser().id,
          relation: Relation.self,
        )
    ));
  }

  Future _onEditInterests() async {
    SonaAnalytics.log('profile_interests');
    final result = await showInterestPicker(context: context);
    if (result != null) {
      ref.read(myProfileProvider.notifier).updateField(interests: result);
    }
  }

  Future onBioEdit() async {
    final controller = TextEditingController(text: ref.read(myProfileProvider)!.bio ?? '');
    final text = await showTextFieldDialog(
      context: context,
      controller: controller,
      hint: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ColoredButton(
            size: ColoredButtonSize.small,
            color: Colors.transparent,
            onTap: () async {
              final resp = await callSona(
                type: CallSonaType.BIO,
                input: controller.text
              );
              if (resp.statusCode == 0 && mounted) {
                Navigator.pop(context);
                final result = await showConfirm(
                  context: context,
                  title: 'Apply?',
                  content: resp.data['txt']
                );
                if (result == true) {
                  ref.read(myProfileProvider.notifier).updateField(bio: resp.data['txt']);
                  SonaAnalytics.log('profile_sona_bio');
                }
              }
            },
            loadingWhenAsyncAction: true,
            text: 'Ask Sona to Optimize',
            fontColor: Theme.of(context).primaryColor
          ),
          SizedBox(width: 40),
        ],
      ),
      maxLength: 360,
      saveFlex: 3,
      cancelFlex: 2
    );
    if (text != null && text.trim().isNotEmpty) {
      ref.read(myProfileProvider.notifier).updateField(bio: text);
      SonaAnalytics.log('profile_bio');
    }
  }

  Future _showGenderEditor() async {
    var gender = await showGenderPicker(
        context: context,
        initialValue: ref.read(myProfileProvider)!.gender,
    );
    if (gender != null && gender != _profile.gender) {
      ref.read(myProfileProvider.notifier).updateField(gender: gender);
      SonaAnalytics.log('profile_gender');
    }
  }

  void _showPhotoActions(int index, Map<String, String> actions) async {
    if (actions.isEmpty) return;
    final photo = _profile.photos[index];
    final action = await showRadioFieldDialog(context: context, options: actions);
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
    final source = await showRadioFieldDialog(context: context, options: {
      'Choose a photo': ImageSource.gallery,
      'Take a photo': ImageSource.camera
    });
    if (source == null) throw Exception('No source');
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    if (file == null) throw Exception('No file');
    if (file.name.toLowerCase().endsWith('.gif')) {
      Fluttertoast.showToast(msg: 'GIF is not allowed');
      return;
    }
    Uint8List? bytes = await file.readAsBytes();
    bytes = await cropImage(bytes);
    if (bytes == null) return;
    await addPhoto(bytes: bytes, filename: file.name);
    ref.read(myProfileProvider.notifier).refresh();
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