import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'convert_state.dart';

class ConvertNotifier extends StateNotifier<ConvertState> {
  final ProductsRepository _productRepository;

  ConvertNotifier(this._productRepository) : super(const ConvertState());

  changeProgress(double value) {
    state = state.copyWith(progress: value);
  }

  setFile(File value) {
    state = state.copyWith(file: value);
  }

  setName(String value) {
    state = state.copyWith(name: value);
  }

  Future<void> uploadFile(BuildContext context, {required int? productId}) async {
    final res = await _productRepository.updateDigitalFile(
        filePath: state.file?.path ?? '', productId: productId);
    res.when(success: (success) {
      state = state.copyWith(file: null);
    }, failure: (failure, status) {
      AppHelpers.showSnackBar(context, AppHelpers.getTranslation(TrKeys.uploadImage));
    });
  }
}
