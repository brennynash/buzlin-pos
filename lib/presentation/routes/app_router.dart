import 'package:admin_desktop/presentation/pages/main/widgets/help/help_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presentation/pages/auth/login/login_page.dart';
import '../../presentation/pages/auth/pin_code/pin_code_page.dart';
import '../../presentation/pages/initial/splash_page.dart';
import '../../presentation/pages/main/main_page.dart';
import '../../presentation/pages/main/widgets/right_side/address/country/pickup_map_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CupertinoRoute(path: '/', page: SplashRoute.page),
        CustomRoute(
          path: '/',
          page: SplashRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/login',
          page: LoginRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/pin_code',
          page: PinCodeRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/main',
          page: MainRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/pickup_map',
          page: PickupMapRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CupertinoRoute(path: '/help', page: HelpRoute.page),
      ];
}
