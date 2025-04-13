import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/application/main/main_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/models/response/edit_profile.dart';
import '../../domain/repository/repository.dart';
import '../../presentation/components/dialogs/successfull_dialog.dart';
import '../../presentation/styles/style.dart';
import 'package:admin_desktop/presentation/routes/app_router.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'edit_profile_state.dart';

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  final GalleryRepositoryFacade _galleryRepository;
  final UsersFacade _userRepository;
  EditProfileNotifier(this._galleryRepository, this._userRepository)
      : super(const EditProfileState());

  Future<void> fetchUser(BuildContext context) async {
    if (LocalStorage.getToken().isNotEmpty) {
      final connected = await AppConnectivity.connectivity();
      if (connected) {
        state = state.copyWith(isLoading: true);

        final response = await _userRepository.getProfileDetails();
        response.when(
          success: (data) async {
            LocalStorage.setUser(data.data);
            state = state.copyWith(isLoading: false, userData: data.data);
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
        if (mounted) {
          // AppHelpers.showNoConnectionSnackBar(context);
        }
      }
    }
  }


  Future<void> getPhoto() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: Style.white,
            toolbarWidgetColor: Style.black,
            initAspectRatio: CropAspectRatioPreset.original,
          ),
          IOSUiSettings(title: 'Image Cropper', minimumAspectRatio: 1),
        ],
      );
      state = state.copyWith(imagePath: croppedFile?.path ?? "");
    }
  }

  changeIndex(int index) {
    state = state.copyWith(selectIndex: index);
  }

  void setPhoneNumber(String phone){
    state = state.copyWith(phoneNumber: phone);
  }

  void setShowPassword(bool show) {
    state = state.copyWith(showPassword: show);
  }

  void setShowOldPassword(bool show) {
    state = state.copyWith(showOldPassword: show);
  }

  void setShowPersonalPincode(bool show) {
    state = state.copyWith(showPincode: show);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setBirth(String birth) {
    state = state.copyWith(birth: birth);
  }

  Future<void> editProfile(BuildContext context, UserData user) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true, isSuccess: false);
      if (state.imagePath.isNotEmpty) {
        // ignore: use_build_context_synchronously
        await updateProfileImage(context, state.imagePath);
      }

      final response = await usersRepository.editProfile(
          user: EditProfile(
        firstname: state.firstName.isEmpty ? user.firstname : state.firstName,
        lastname: state.lastName.isEmpty ? user.lastname : state.lastName,
        birthday: state.birth.isEmpty ? user.birthday : state.birth,
        phone: state.phone.isEmpty ? user.phone : state.phone,
        images: state.url.isEmpty ? user.img ?? "" : state.url,
        gender: state.gender,
      ));
      response.when(
        success: (data) {
          LocalStorage.setUser(data.data);

          state = state.copyWith(
            userData: data.data,
            isLoading: false,
            isSuccess: true,
          );

          showDialog(
              context: context,
              builder: (_) => Dialog(child: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return SuccessDialog(
                          title:
                              AppHelpers.getTranslation(TrKeys.profileEdited),
                          content: AppHelpers.getTranslation(TrKeys.goToHome),
                          onPressed: () {
                            Navigator.pop(context);
                            ref.read(mainProvider.notifier).changeIndex(0);
                          });
                    },
                  )));
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
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




  Future<void> updatePassword(BuildContext context,
      {required String password, required String confirmPassword}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true, isSuccess: false);
      final response = await usersRepository.updatePassword(
        password: password,
        passwordConfirmation: confirmPassword,
      );
      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false, isSuccess: true);
          context.replaceRoute(const MainRoute());
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
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

  Future<void> updateProfileImage(BuildContext context, String path) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      String? url;
      final imageResponse =
          await _galleryRepository.uploadImage(path, UploadType.users);
      imageResponse.when(
        success: (data) {
          url = data.imageData?.title;
          state = state.copyWith(url: url ?? "");
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> upload profile image failure: $failure');
          AppHelpers.showSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (context.mounted) {
        state = state.copyWith(isLoading: false);
        AppHelpers.showSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      }
    }
  }


}
