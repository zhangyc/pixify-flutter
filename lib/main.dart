import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sona/utils/providers/firebase.dart';
import 'package:sona/utils/providers/kv_store.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final firebase = await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  final preferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // firebaseProvider.overrideWithValue(firebase),
        kvStoreProvider.overrideWithValue(preferences)
      ],
      child: const SonaApp()
    )
  );
}
