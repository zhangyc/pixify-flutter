import 'dart:typed_data';

import 'package:sona/utils/toast/flutter_toast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../account/providers/profile.dart';
import '../../../account/services/info.dart';
import '../../../utils/dialog/crop_image.dart';

setUserAvatarPhoto(ImageSource source,ref) async{
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
  await setAvatarPhoto(bytes: bytes,);
  ref.read(myProfileProvider.notifier).refresh();
}