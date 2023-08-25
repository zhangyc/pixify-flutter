import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/user_info.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/core/persona/providers/persona.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/picker/gender.dart';

import '../utils/providers/dio.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  late MyInfo _profile;

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
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    alignment: Alignment.center,
                    child: const Text('My Bio'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _sonaWritesBio,
                    child: Text('Sona writes for me'),
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
        onTap: () {
          // _onAddPhoto();
        },
        child: Center(child: Icon(Icons.add, size: 36))
      );
    } else {
      final photo = _profile.photos[index];
      child = CachedNetworkImage(imageUrl: photo, fit: BoxFit.cover);
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
        borderRadius: BorderRadius.circular(12)
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
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
    final dio = ref.read(dioProvider);

    var bio = '';
    final resp = await dio.get('/persona');
    final data = resp.data;
    if (data['code'] == 1 && data['data']['intro'] != null) {
      bio = data['data']['intro'];
    }
    final text = await showTextFieldDialog(context: context, initialText: bio);
    if (text != null && text.trim().isNotEmpty) {
      final dio = ref.read(dioProvider);
      final resp = await dio.post('/persona', data: {'intro': bio});
      if (resp.data['code'] == 1) {
        FocusManager.instance.primaryFocus?.unfocus();
        Fluttertoast.showToast(msg: '设置成功');
      } else {
        Fluttertoast.showToast(msg: 'Failed');
      }
    }
  }

  Future _showGenderEditor() async {
    var gender = await showGenderPicker(context: context);
    if (gender != null && gender != _profile.gender) {
      ref.read(asyncMyProfileProvider.notifier).updateInfo(gender: gender);
    }
  }
}