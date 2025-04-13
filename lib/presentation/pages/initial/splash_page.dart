import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/presentation/routes/app_router.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../application/initial/splash_provider.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        if(mounted) {
          ref.read(splashProvider.notifier)
          ..fetchGlobalSettings(
            context,
            checkYourNetwork: () {
              AppHelpers.showSnackBar(
                context,
                TrKeys.checkYourNetworkConnection,
              );
            },
          )
          ..fetchProfileDetails((value) {}, () {
            LocalStorage.deleteToken();
            context.pushRoute(const LoginRoute());
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Style.white,
      body: Center(
        child: CircularProgressIndicator(color: Style.black),
      ),
    );
  }
}
