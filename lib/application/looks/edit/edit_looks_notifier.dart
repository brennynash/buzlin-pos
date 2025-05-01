import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'edit_looks_state.dart';

class EditLooksNotifier extends StateNotifier<EditLooksState> {
  final LooksRepository _looksRepository;
  final SettingsRepository _settingsRepository;

  EditLooksNotifier(this._looksRepository, this._settingsRepository)
      : super(const EditLooksState());

  void changeActive(bool? active) {
    state = state.copyWith(active: !state.active);
  }

  void clear() {
    state = state.copyWith(active: false, products: [], imageFile: null);
  }


  void deleteFromAddedProducts(int? id) {
    List<ProductData> temp = List.from(state.products);
    temp.removeWhere((element) => element.id == id);
    state = state.copyWith(products: temp);
  }

  void setLookProducts(ProductData product) {
    List<ProductData> list = List.from(state.products);
    if (state.products.any((element) => element.id == product.id)) {
      list.removeWhere((element) => element.id == product.id);
    } else {
      list.add(product);
    }
    state = state.copyWith(products: list);
  }

  void setImageFile(String? file) {
    state = state.copyWith(imageFile: file);
  }

  Future<void> fetchLookDetails(
      {required BuildContext context, required int id}) async {
    state = state.copyWith(isLoading: true);
    final res = await _looksRepository.getLooksDetails(id: id);
    res.when(success: (data) {
      List<ProductData> list = [];
      list.addAll(data.data?.products ?? []);
      state = state.copyWith(isLoading: false, products: list,looksData: data.data);
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.showSnackBar(context, failure);
    });
  }

  Future<void> updateLook(
    BuildContext context, {
    required String title,
    required String description,
    ValueChanged<LooksData?>? updated,
    VoidCallback? failed,
  }) async {
    state = state.copyWith(isLoading: true);
    String? imageUrl;
    if (state.imageFile != null) {
      final imageResponse = await _settingsRepository.uploadImage(
        state.imageFile!,
        UploadType.products,
      );
      imageResponse.when(
        success: (data) {
          imageUrl = data.imageData?.title;
        },
        failure: (failure, status) {
          debugPrint('==> upload looks image fail: $failure');
          AppHelpers.showSnackBar(context, failure.toString());
        },
      );
    }
    final response = await _looksRepository.updateLooks(
      active: state.active,
      image: imageUrl,
      title: title,
      description: description,
      products: state.products.map((e) => e.id).toList(),
      id: state.looksData?.id ?? 0,
    );
    response.when(
      success: (data) {
        state = state.copyWith(imageFile: null, isLoading: false, products: []);
        updated?.call(data.data);
      },
      failure: (fail, status) {
        AppHelpers.showSnackBar(context, fail);
        state = state.copyWith(isLoading: false);
        debugPrint('===> looks update fail $fail');
        failed?.call();
      },
    );
  }

  Future<void> setDetails(LooksData? looks) async {
    state = state.copyWith(
      looksData: looks,
      active: looks?.active ?? true,
    );
  }
}
