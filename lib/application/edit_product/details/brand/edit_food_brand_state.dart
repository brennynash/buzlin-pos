import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/models/data/brand_data.dart';
part 'edit_food_brand_state.freezed.dart';

@freezed
class EditFoodBrandState with _$EditFoodBrandState {
  const factory EditFoodBrandState({
    @Default([]) List<Brand> brands,
    @Default(null) Brand? selectedBrand,
    TextEditingController? brandController,
    @Default(false) bool isLoading,
  }) = _EditFoodBrandState;

  const EditFoodBrandState._();
}
