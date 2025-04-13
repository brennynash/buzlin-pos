import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'create_ads_state.dart';

class CreateAdsNotifier extends StateNotifier<CreateExtrasGroupState> {
  final AdsRepository _adsRepository;

  CreateAdsNotifier(this._adsRepository)
      : super(const CreateExtrasGroupState());

  void setProducts(ProductData product) {
    List<ProductData> list = List.from(state.products);
    if (state.products.any((element) => element.id == product.id)) {
      list.removeWhere((element) => element.id == product.id);
    } else {
      list.add(product);
    }
    state = state.copyWith(products: list);
  }

  void setPackage(AdsPackage? value) {
    state = state.copyWith(package: value);
  }

  Future<void> assignAds(
    BuildContext context, {
    VoidCallback? updated,
    VoidCallback? failed,
  }) async {
    if (state.products.isEmpty) return;
    state = state.copyWith(isLoading: true);
    final response = await _adsRepository.addAdsPackages(
      productIds: state.products.map((e) => e.id).toList(),
      id: state.package?.id ?? 0,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false, products: [], package: null);
        updated?.call();
       Navigator.pop(context);
      },
      failure: (fail, status) {
        AppHelpers.showSnackBar(context, fail);
        state = state.copyWith(isLoading: false);
        debugPrint('===> assign ads fail $fail');
        failed?.call();
        Navigator.pop(context);
      },
    );
  }
}
