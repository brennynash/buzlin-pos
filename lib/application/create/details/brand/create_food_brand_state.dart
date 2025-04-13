import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';

part 'create_food_brand_state.freezed.dart';

@freezed
class CreateFoodBrandState with _$CreateFoodBrandState {
  const factory CreateFoodBrandState({
    @Default([]) List<Brand> brands,
    @Default(null) Brand? selectedBrand,
    TextEditingController? brandController,
  }) = _CreateFoodBrandState;

  const CreateFoodBrandState._();
}
