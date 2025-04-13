import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/application/main/main_provider.dart';
import '../../domain/models/data/customer_data.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import '../../presentation/components/dialogs/successfull_dialog.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'customer_state.dart';

class CustomerNotifier extends StateNotifier<CustomerState> {
  final UsersFacade _usersRepository;
  final SettingsRepository _settingsRepository;
  int _page = 0;

  CustomerNotifier(
      this._usersRepository, this._settingsRepository,
      ) : super(const CustomerState());

  void setUser(UserData? user) {
    state = state.copyWith(selectUser: user);
  }

  void setImageFile(String? file) {
    state = state.copyWith(imageFile: file);
  }

  Future<void> fetchAllUsers({
    VoidCallback? checkYourNetwork,
  }) async {
    if (!state.hasMore) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_page == 0) {
        state = state.copyWith(isLoading: true, users: []);

        final response = await _usersRepository.getUsers(
          page: ++_page,
        );
        response.when(
          success: (data) {
            state = state.copyWith(
              users: data.users ?? [],
              isLoading: false,
            );
            if ((data.users?.length ?? 0) < 5) {
              state = state.copyWith(hasMore: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isLoading: false);
            debugPrint('==> get products failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreLoading: true);
        final response = await _usersRepository.getUsers(page: ++_page);
        response.when(
          success: (data) async {
            final List<UserData> newList = List.from(state.users);
            newList.addAll(data.users ?? []);
            state = state.copyWith(
              users: newList,
              isMoreLoading: false,
            );
            if ((data.users?.length ?? 0) < 5) {
              state = state.copyWith(hasMore: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isMoreLoading: false);
            debugPrint('==> get users  failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> createCustomer(BuildContext context,
      {required String name,
        required String lastName,
        required String email,
        required String phone,
        String? createRole,
        String? password,
        String? description,
        String? title,
        Function(UserData?)? created,
        bool needAlert = true
      }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(createUserLoading: true);
      String? imageUrl;
      if (state.imageFile?.isNotEmpty ?? false) {
        final res = await _settingsRepository.uploadImage(
            state.imageFile!, UploadType.users);
        res.when(success: (success) {
          imageUrl = success.imageData?.path;
        }, failure: (failure, success) {
          debugPrint('==> upload service image fail: $failure');
          AppHelpers.errorSnackBar(context, text: failure);
        });
      }
      final response = await _usersRepository.createUser(
          query: CustomerData(
              imageUrl: imageUrl,
              role: createRole ?? 'user',
              firstname: name,
              lastname: lastName,
              email: email,
              phone: int.tryParse(phone),
              password: password,
              title: title,
              description: description
          ));
      response.when(
        success: (data) {
          state = state.copyWith(
            user: data.data,
            createUserLoading: false,
          );
          created?.call(data.data);
          if(needAlert) {
            showDialog(
                context: context,
                builder: (_) => Dialog(child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return SuccessDialog(
                        title: AppHelpers.getTranslation(TrKeys.customerAdded),
                        content: AppHelpers.getTranslation(TrKeys.goToHome),
                        onPressed: () {
                          Navigator.pop(context);
                          ref.read(mainProvider.notifier).changeIndex(0);
                        });
                  },
                )
                )
            );
          }
        },
        failure: (failure, status) {
          state = state.copyWith(createUserLoading: false);
          AppHelpers.showSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (context.mounted) {
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      }
    }
  }
  Future<void> searchUsers(BuildContext context, String text) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (state.query == text) {
        return;
      }
      state = state.copyWith(isLoading: true, query: text);
      final response = await _usersRepository.searchUsers(query: text.trim());
      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false, users: data.users ?? []);
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showSnackBar(
            context,
            AppHelpers.getTranslation(failure),
          );
        },
      );
    } else {
      if (context.mounted) {
        AppHelpers.showSnackBar(context, mounted.toString());
      }
    }
  }
}
