import 'dart:async';

import 'package:sona/core/chat/models/message.dart';

final messageStream = StreamController<ImMessage>.broadcast().stream;
