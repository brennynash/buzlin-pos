import 'dart:io';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import '../domain/di/dependency_manager.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../domain/repository/repository.dart';
import 'components/components.dart';
import 'routes/app_router.dart';
import 'styles/style.dart';
import 'theme/light_theme.dart';
import 'theme/theme/theme.dart';

@pragma('vm:entry-point')
Future<int> getOtherTranslation(int arg) async {
  final settingsRepository = SettingsSettingsRepositoryImpl();
  final res = await settingsRepository.getLanguages();
  res.when(
      success: (l) {
        l.data?.forEach((e) async {
          final translations =
              await settingsRepository.getMobileTranslations(lang: e.locale);
          translations.when(
              success: (d) {
                LocalStorage.setOtherTranslations(
                    translations: d.data, key: e.id.toString());
              },
              failure: (f, s) => null);
        });
      },
      failure: (f, s) => null);
  return 0;
}

Future<int> getOtherTranslationForDesktop(int arg) async {
  final res = await settingsRepository.getLanguages();
  res.when(
      success: (l) {
        l.data?.forEach((e) async {
          final translations =
              await settingsRepository.getMobileTranslations(lang: e.locale);
          translations.when(
              success: (d) {
                LocalStorage.setOtherTranslations(
                    translations: d.data, key: e.id.toString());
              },
              failure: (f, s) => null);
        });
      },
      failure: (f, s) => null);
  return 0;
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  Future<Future<FlutterIsolate>> isolate() async {
    return FlutterIsolate.spawn(getOtherTranslation, 0);
  }

  @override
  void initState() {
    if (LocalStorage.getTranslations().isNotEmpty) {
      fetchSettingNoAwait();
    }
    if (Platform.isMacOS || Platform.isWindows || Platform.isWindows) {
      getOtherTranslationForDesktop(0);
    } else {
      isolate();
    }
    super.initState();
  }

  Future fetchSetting() async {
    final connect = await Connectivity().checkConnectivity();
    if (connect.contains(ConnectivityResult.wifi) ||
        connect.contains(ConnectivityResult.mobile)) {
      settingsRepository.getGlobalSettings();
      await settingsRepository.getLanguages();
      await settingsRepository.getTranslations();
      // if (LocalStorage.getSelectedCurrency() == null) {
      //   settingsRepository.getCurrencies();
      // }
    }
  }

  Future fetchSettingNoAwait() async {
    settingsRepository.getGlobalSettings();
    settingsRepository.getLanguages();
    settingsRepository.getTranslations();
    // if (LocalStorage.getSelectedCurrency() == null) {
    //   settingsRepository.getCurrencies();
    // }
  }

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait({
          AppTheme.create,
          if (LocalStorage.getTranslations().isEmpty) fetchSetting(),
        }),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            final AppTheme theme = snapshot.data?[0];
            return ScreenUtilInit(
              designSize: const Size(1194, 900),
              builder: (context, child) {
                return ChangeNotifierProvider(
                  create: (BuildContext context) => theme,
                  child: MaterialApp.router(
                    theme: lightTheme(),
                    scrollBehavior: CustomScrollBehavior(),
                    debugShowCheckedModeBanner: false,
                    routerDelegate: appRouter.delegate(),
                    routeInformationParser: appRouter.defaultRouteParser(),
                    locale: Locale(LocalStorage.getLanguage()?.locale ?? 'en'),
                    color: Style.white,
                    builder: (context, child) => ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: child ?? const SizedBox.shrink(),
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
