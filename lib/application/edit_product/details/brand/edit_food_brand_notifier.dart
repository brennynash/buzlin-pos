// ignore_for_file: sdk_version_since
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'edit_food_brand_state.dart';

class EditFoodBrandNotifier extends StateNotifier<EditFoodBrandState> {
  EditFoodBrandNotifier()
      : super(EditFoodBrandState(brandController: TextEditingController()));

  void setActiveBrand(Brand? brand) {
    if (state.selectedBrand?.id == brand?.id) {
      return;
    }
    state = state.copyWith(selectedBrand: brand);
    state.brandController?.text =brand?.title ?? '';
  }


  void setBrands(List<Brand> brands) {
    if(state.brands.isNotEmpty){
      return;
    }
    state = state.copyWith(brands: brands);
  }
}
