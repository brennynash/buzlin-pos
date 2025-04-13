import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';

import '../../../../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'create_brand_state.dart';

class CreateBrandNotifier extends StateNotifier<CreateBrandState> {
  final BrandsRepository _brandsRepository;
  final GalleryRepositoryFacade _galleryRepository;

  CreateBrandNotifier(
    this._brandsRepository,
    this._galleryRepository,
  ) : super(const CreateBrandState());

  void changeActive(bool? active) {
    state = state.copyWith(active: !state.active);
  }

  void setBrand(Brand brand) {
    state = state.copyWith(
        brand: brand, active: brand.active ?? true, title: brand.title ?? '');
  }

  void clear() {
    state = state.copyWith(
      brand: null,
      active: true,
      imageFile: null,
      isLoading: false,
    );
  }

  Future<void> createBrand(
    BuildContext context, {
    VoidCallback? created,
    VoidCallback? onError,
  }) async {
    state = state.copyWith(isLoading: true);
    String? imageUrl;
    if (state.imageFile != null) {
      final imageResponse = await _galleryRepository.uploadImage(
        state.imageFile!,
        UploadType.brands,
      );
      imageResponse.when(
        success: (data) {
          imageUrl = data.imageData?.title;
        },
        failure: (failure, status) {
          debugPrint('==> upload product image fail: $failure');
          AppHelpers.showSnackBar(context,  failure);
        },
      );
    }
    final response = await _brandsRepository.addBrand(
      active: state.active,
      image: imageUrl,
      title: state.title,
    );
    response.when(
      success: (data) {
        state = state.copyWith(
          isLoading: false,
        );
        created?.call();
      },
      failure: (failure, status) {
        debugPrint('===> create product fail $failure');
        state = state.copyWith(isLoading: false);
        AppHelpers.showSnackBar(context,  failure);

        onError?.call();
      },
    );
  }

  Future<void> updateBrand(BuildContext context,
      {VoidCallback? created, VoidCallback? onError}) async {
    state = state.copyWith(isLoading: true);
    String? imageUrl;
    if (state.imageFile != null) {
      final imageResponse = await _galleryRepository.uploadImage(
        state.imageFile!,
        UploadType.products,
      );
      imageResponse.when(
        success: (data) {
          imageUrl = data.imageData?.title;
        },
        failure: (failure, status) {
          debugPrint('==> upload product image fail: $failure');
          AppHelpers.showSnackBar(context,  failure);
        },
      );
    }
    final response = await _brandsRepository.addBrand(
      active: state.active,
      image: imageUrl ?? state.brand?.img,
      title: state.title,
    );
    response.when(
      success: (data) {
        state = state.copyWith(
          isLoading: false,
        );
        created?.call();
      },
      failure: (failure, status) {
        debugPrint('===> create product fail $failure');
        state = state.copyWith(isLoading: false);
        AppHelpers.showSnackBar(context,  failure);

        onError?.call();
      },
    );
  }

  void setActive(bool? value) {
    state = state.copyWith(active: !state.active);
    debugPrint('===> set active ${state.active}');
  }

  void setTitle(String value) {
    state = state.copyWith(title: value.trim());
  }

  void setImageFile(String? file) {
    state = state.copyWith(imageFile: file);
  }
}
