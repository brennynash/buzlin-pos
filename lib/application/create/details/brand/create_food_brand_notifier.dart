// ignore_for_file: sdk_version_since
import 'dart:async';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repository/repository.dart';
import '../../../../infrastructure/services/utils.dart';
import 'create_food_brand_state.dart';

class CreateFoodBrandNotifier extends StateNotifier<CreateFoodBrandState> {
  final BrandsRepository _brandsRepository;
  int _page = 0;

  CreateFoodBrandNotifier(this._brandsRepository)
      : super(CreateFoodBrandState(brandController: TextEditingController()));

  void clearAll() {
    state.brandController?.clear();
    state = state.copyWith(selectedBrand: null);
  }

  Future<void> updateBrands(BuildContext context) async {
    _page = 0;
    final response = await _brandsRepository.getBrands(page: ++_page);
    response.when(
      success: (data) {
        List<Brand> brands = List.from(state.brands);
        final List<Brand> newBrands = data.data ?? [];
        for (final brand in newBrands) {
          bool contains = false;
          for (final oldBrand in brands) {
            if (brand.id == oldBrand.id) {
              contains = true;
            }
          }
          if (!contains) {
            brands.insert(0, brand);
          }
        }
        state = state.copyWith(brands: brands, selectedBrand: null);
        if (brands.isNotEmpty) {
          state.brandController?.text = state.brands[0].title ?? '';
        }
      },
      failure: (failure, status) {
        debugPrint('====> fetch categories fail $failure');
        _page--;
        AppHelpers.showSnackBar(context, failure);
      },
    );
  }

  void setActiveBrand(Brand selectBrand) {
    if (state.selectedBrand?.id == selectBrand.id) {
      return;
    }
    state = state.copyWith(selectedBrand: selectBrand);
    state.brandController?.text = selectBrand.title ?? '';
  }

  void setBrands(List<Brand> brands) {
    _page = 0;
    if (state.brands.isEmpty) {
      if (brands.isNotEmpty) {
        state.brandController?.text = brands[0].title ?? '';
      }
    }

    state = state.copyWith(brands: brands, selectedBrand: null);
  }
}
