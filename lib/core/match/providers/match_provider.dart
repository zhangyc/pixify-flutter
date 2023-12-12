// 1. 创建一个Notifier管理分页状态

import 'package:hooks_riverpod/hooks_riverpod.dart';


final backgroundImageProvider = StateNotifierProvider<BackgroundColorController, String?>(
      (ref) => BackgroundColorController(),
);

class BackgroundColorController extends StateNotifier<String?> {
  BackgroundColorController() : super(null);

  void updateBgImage(String? url) {
    state = url;
  }
}



List whiteTable=[
  18301579950,
  18600463136,
  13325745202,
  18811785120,
  13683358810
];

