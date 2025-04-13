import 'dart:async';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'shop_state.dart';

class ShopNotifier extends StateNotifier<ShopState> {
  String _statusNote = '';
  String _title = '';
  String _description = '';
  String _phone = '';
  String _deliveryType = '';
  String _from = '';
  String _to = '';
  String _tax = '';
  String _percentage = '';

  ShopNotifier() : super(const ShopState());
  Timer? timer;

  void setCloseDay(int index) {
    ShopData? closeDays = state.editShopData;
    ShopWorkingDay? workingDays = closeDays?.shopWorkingDays?[index];
    workingDays =
        workingDays?.copyWith(disabled: !(workingDays.disabled ?? false));
    closeDays?.shopWorkingDays?[index] = workingDays ?? ShopWorkingDay();
    state = state.copyWith(editShopData: closeDays);
  }

  void setUpdate() {
    state = state.copyWith(isLogoImageLoading: true);
    state = state.copyWith(isLogoImageLoading: false);
  }

  void setStatusNote(String value) {
    _statusNote = value.trim();
  }

  void setPhone(String value) {
    _phone = value.trim();
  }

  void setDescription(String value) {
    _description = value.trim();
  }

  void setTitle(String value) {
    _title = value.trim();
  }

  void setFrom(String value) {
    _from = value.trim();
  }

  void setTo(String value) {
    _to = value.trim();
  }

  void setTax(String value) {
    _tax = value.trim();
  }

  void setPercentage(String value) {
    _percentage = value.trim();
  }
  void setCountryId(int? value) {
    state = state.copyWith(countryId: value);
  }

  void setCityId(int? value) {
    state = state.copyWith(cityId: value);
  }

  void setRegionId(int? value) {
    state = state.copyWith(regionId: value);
  }

  Future<void> fetchShopData(
      {VoidCallback? checkYourNetwork, VoidCallback? onSuccess}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isEditShopData: true);
      final response = await shopsRepository.getShopData();
      await fetchShopTag();
      await fetchShopCategory();
      response.when(
        success: (data) async {
          onSuccess?.call();
          state = state.copyWith(
              isEditShopData: false, editShopData: data, isUpdate: false);
        },
        failure: (failure, status) {
          state = state.copyWith(isEditShopData: false);
          debugPrint('==> get editShopData failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchShopCategory({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final response = await shopsRepository.getShopCategory();
      response.when(
        success: (data) async {
          state = state.copyWith(categories: data);
        },
        failure: (failure, status) {
          debugPrint('==> get editShopCategory failure: $failure');
          // AppHelpers.showSnackBar(
          //   context,
          //   failure,
          // );
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchShopTag({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final response = await shopsRepository.getShopTag();
      response.when(
        success: (data) async {
          state = state.copyWith(tag: data);
        },
        failure: (failure, status) {
          debugPrint('==> get editShopTag failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setDeliveryType(String value) {
    _deliveryType = value.trim();
  }

  Future<void> updateShopData({
    required ValueChanged<ShopData?>? onSuccess,
    required LocationData? location,
    String? displayName,
    List<ValueItem>? category,
    List<ValueItem>? tag,
    List<ValueItem>? type,
  }) async {
    state = state.copyWith(isSave: true);
    final response = await shopsRepository.updateShopData(
        displayName: displayName,
        category: category,
        tag: tag,
        type: type,
        editShopData: ShopData(
            latLong: state.editShopData?.latLong,
            status: state.editShopData?.status,
            statusNote: _statusNote.isNotEmpty
                ? _statusNote
                : state.editShopData?.statusNote,
            translation: Translation(
                title: _title.isNotEmpty
                    ? _title
                    : state.editShopData?.translation?.title,
                description: _description.isNotEmpty
                    ? _description
                    : state.editShopData?.translation?.description),
            phone: _phone.isNotEmpty ? _phone : state.editShopData?.phone,
            // price: _price.isNotEmpty
            //     ? num.tryParse(_price)
            //     : state.editShopData?.price,
            // minAmount: _minAmount.isNotEmpty
            //     ? int.tryParse(_minAmount)
            //     : state.editShopData?.minAmount,
            // perKm: _perKm.isNotEmpty
            //     ? num.tryParse(_perKm)
            //     : state.editShopData?.perKm,
            deliveryTime: DeliveryTime(
                from: _from.isNotEmpty
                    ? _from
                    : state.editShopData?.deliveryTime?.from,
                to: _to.isNotEmpty
                    ? _to
                    : state.editShopData?.deliveryTime?.to),
            tax: _tax.isNotEmpty ? int.tryParse(_tax) : state.editShopData?.tax,
            deliveryType: _deliveryType == TrKeys.inHouse ? 1 : 2,
            percentage: _percentage.isNotEmpty
                ? int.tryParse(_percentage)
                : state.editShopData?.percentage),
        logoImg: state.logoImageUrl,
        backImg: state.backImageUrl);
    response.when(
      success: (data) {
        state = state.copyWith(isSave: false, isUpdate: true);
        onSuccess?.call(data);
      },
      failure: (fail, status) {
        state = state.copyWith(isSave: false);
        debugPrint('===> update delivery zone failed $fail');
      },
    );
  }

  Future<void> updateWorkingDays({
    required List<ShopWorkingDay> days,
    required String shopUuid,
  }) async {
    state = state.copyWith(isSave: true);
    final response = await shopsRepository.updateShopWorkingDays(
      workingDays: days,
      uuid: shopUuid,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isSave: true);
      },
      failure: (failure, status) {
        state = state.copyWith(isSave: false);
        debugPrint('==> error update working days $failure');
      },
    );
  }

  Future<void> getPhoto(
      {bool isLogoImage = false, required BuildContext context}) async {
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
      // ignore: use_build_context_synchronously
      await updateShopImage(context, croppedFile?.path ?? "", isLogoImage);
      state = isLogoImage
          ? state.copyWith(logoImagePath: croppedFile?.path ?? "")
          : state.copyWith(backImagePath: croppedFile?.path ?? "");
    }
  }

  void setSelectedOrderType(String? type) {
    state = state.copyWith(orderType: type ?? state.orderType);
  }

  setNote(String note) {
    state = state.copyWith(comment: note);
  }

  Future<void> updateShopImage(
      BuildContext context, String path, bool isLogoImage) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = isLogoImage
          ? state.copyWith(isLogoImageLoading: true)
          : state.copyWith(isBackImageLoading: true);
      String? url;
      final imageResponse =
      await galleryRepository.uploadImage(path, UploadType.users);
      imageResponse.when(
        success: (data) {
          url = data.imageData?.title;
          state = isLogoImage
              ? state.copyWith(
              logoImageUrl: url ?? "", isLogoImageLoading: false)
              : state.copyWith(
              backImageUrl: url ?? "", isBackImageLoading: false);
        },
        failure: (failure, status) {
          state = isLogoImage
              ? state.copyWith(isLogoImageLoading: false)
              : state.copyWith(isBackImageLoading: false);
          debugPrint('==> upload edit shop image failure: $failure');
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


  Future<void> addShopLocations(BuildContext context,
      {VoidCallback? updateSuccess}) async {
    if (state.regionId == null || state.countryId == null) {
      return;
    }
    bool? cityExist = state.editShopData?.locations
        ?.any((element) => element.city?.id == (state.cityId ?? 0));
    if (cityExist ?? false) {
      return;
    }
    bool? countryExists = state.editShopData?.locations
        ?.any((element) => element.country?.id == state.countryId!);

    if (countryExists ?? false) {
      List<Location>? temp = state.editShopData?.locations
          ?.where((element) => element.countryId == state.countryId)
          .toList();
      if (temp != null) {
        for (int i = 0; i < temp.length; i++) {
          if (temp[i].cityId == null && state.cityId == null) {
            return;
          }
        }
      }
    }

    state = state.copyWith(isShopLocationsLoading: true);
    final response = await shopsRepository.addShopLocations(
        regionId: state.regionId!,
        countryId: state.countryId!,
        cityId: state.cityId);
    response.when(
      success: (data) {
        state = state.copyWith(
          isShopLocationsLoading: false,
          countryId: null,
          cityId: null,
          regionId: null,
        );
        updateSuccess?.call();
      },
      failure: (failure, status) {
        debugPrint('===> add locations fail $failure');
        state = state.copyWith(isShopLocationsLoading: false);
        AppHelpers.showSnackBar(context, failure);
      },
    );
  }

  Future<void> deleteShopLocation(BuildContext context, int id,
      {VoidCallback? updateSuccess}) async {
    state = state.copyWith(isEditShopData: true);

    final response = await shopsRepository.deleteShopLocation(
      countryId: id,
    );
    response.when(
      success: (data) {
        var temp = state.editShopData;
        temp?.locations?.removeWhere((element) => element.id == id);

        state = state.copyWith(
          editShopData: temp,
          isEditShopData: false,
        );
        updateSuccess?.call();
      },
      failure: (failure, status) {
        state = state.copyWith(isEditShopData: false);
        debugPrint('===> delete locations fail $failure');
        AppHelpers.showSnackBar(context, failure);
      },
    );
  }
}
