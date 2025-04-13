import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/presentation/routes/app_router.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'splash_state.dart';

class SplashNotifier extends StateNotifier<SplashState> {
  final SettingsRepository _settingsRepository;
  final UsersFacade _userRepository;

  SplashNotifier(this._settingsRepository, this._userRepository) : super(const SplashState());
  Future<void> fetchProfileDetails(
      ValueChanged<UserData?>? onSuccess, VoidCallback goLogin) async {
    final response = await _userRepository.getProfileDetails();
    response.when(
      success: (data) {
        LocalStorage.setUser(data.data);
        if (data.data?.wallet != null) {
          LocalStorage.setWallet(data.data?.wallet);
        }
        onSuccess?.call(data.data);
      },
      failure: (failure, status) {
        if (status == 401) {
          goLogin();
        }
        debugPrint('==> error with fetching profile $failure');
      },
    );
  }
  Future<void> fetchGlobalSettings(
    BuildContext context, {
    VoidCallback? checkYourNetwork,
  }) async {
    if (LocalStorage.getLanguage()?.locale != null) {
      final connect = await AppConnectivity.connectivity();
      if (connect) {
        final response = await _settingsRepository.getGlobalSettings();
        response.when(
          success: (data) async {
            await LocalStorage.setSettingsList(data.data ?? []);
            //await LocalStorage.setLanguageData(LanguageData(title: AppHelpers.getInitialLocale()));
            getTranslations(
              goLogin: () {
                context.replaceRoute(const LoginRoute());
              },
              goMain: () {
                bool checkPin = LocalStorage.getPinCode().isEmpty;
                context.replaceRoute(PinCodeRoute(isNewPassword: checkPin));
              },
            );
          },
          failure: (failure, status) {
            debugPrint('==> error with settings fetched');
            getTranslations(
              goLogin: () {
                context.replaceRoute(const LoginRoute());
              },
              goMain: () {
                if(status == 401){
                  context.replaceRoute(const LoginRoute());
                  return;
                }
                bool checkPin = LocalStorage.getPinCode().isEmpty;
                context.replaceRoute(PinCodeRoute(isNewPassword: checkPin));
              },
            );
          },
        );
      } else {
        debugPrint('==> get active languages no connection');
        checkYourNetwork?.call();
      }
    } else {
      getTranslations(
        goLogin: () {
          context.replaceRoute(const LoginRoute());
        },
        goMain: () {
          bool checkPin = LocalStorage.getPinCode().isEmpty;
          context.replaceRoute(PinCodeRoute(isNewPassword: checkPin));
        },
      );
    }
  }

  Future<void> getTranslations({
    VoidCallback? goMain,
    VoidCallback? goLogin,
  }) async {
    final response = await _settingsRepository.getTranslations();
    response.when(
      success: (data) async {
        await LocalStorage.setTranslations(data.data);
        if (LocalStorage.getToken().isEmpty) {
          goLogin?.call();
        } else {
          goMain?.call();
        }
      },
      failure: (failure, status) {
        debugPrint('==> error with fetching translations $failure');
        if (LocalStorage.getToken().isEmpty) {
          goLogin?.call();
        } else {
          goMain?.call();
        }
      },
    );
  }
}
