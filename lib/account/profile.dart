import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/persona/providers/persona.dart';
import 'package:sona/utils/dialog/input.dart';

import '../utils/providers/dio.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              _photoBuilder,
              childCount: 9
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.6
            )
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
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _showGenderEditor,
              child: Container(
                height: 56,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text('性别'),
                    Expanded(child: Container()),
                    Text('男'),
                    SizedBox(width: 8),
                    Icon(CupertinoIcons.forward)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _photoBuilder(BuildContext context, int index) {
    return Container(
      height: 108,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
          borderRadius: BorderRadius.circular(12)
      ),
      alignment: Alignment.center,
      child: Icon(Icons.add, size: 36,),
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
    final dio = ref.read(dioProvider);

    var gender = 1;
    final resp = await dio.get('/persona');
    final data = resp.data;
    if (data['code'] == 1 && data['data']['intro'] != null) {
      gender = data['data']['gender'] ?? 0;
    }
    
    final g = await showRadioFieldDialog<int>(
      context: context,
      options: [0, 1],
      labels: ['女', '男'],
      initialValue: gender
    );

    if (g != null && g != gender) {
      final dio = ref.read(dioProvider);
      final resp = await dio.post('/persona', data: {'gender': g});
      if (resp.data['code'] == 1) {
        Fluttertoast.showToast(msg: '设置成功');
      } else {
        Fluttertoast.showToast(msg: 'Failed');
      }
    }
  }
}