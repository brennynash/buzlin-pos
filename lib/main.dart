import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'domain/di/dependency_manager.dart';
import 'dart:io' show Platform;

import 'presentation/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpDependencies();
  if(Platform.isAndroid || Platform.isIOS){
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    doWhenWindowReady(() {
      const initialSize = Size(1280, 720);
      const minSize = Size(1024, 576);
      // const maxSize = Size(1280, 720);
      // appWindow.maxSize = maxSize;
      appWindow.minSize = minSize;
      appWindow.size = initialSize; //default size
      appWindow.show();
    });
  }

  await LocalStorage.init();
  initializeDateFormatting(LocalStorage.getLanguage()?.locale, null);
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  runApp(const ProviderScope(child: AppWidget()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
