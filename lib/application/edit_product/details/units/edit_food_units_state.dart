import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'edit_food_units_state.freezed.dart';

@freezed
class EditFoodUnitsState with _$EditFoodUnitsState {
  const factory EditFoodUnitsState({
    @Default(false) bool isLoading,
    @Default([]) List<UnitData> units,
    @Default(0) int activeIndex,
    TextEditingController? unitController,
    UnitData? foodUnit,
  }) = _EditFoodUnitsState;

  const EditFoodUnitsState._();
}
