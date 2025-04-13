import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'create_food_units_state.freezed.dart';

@freezed
class CreateFoodUnitsState with _$CreateFoodUnitsState {
  const factory CreateFoodUnitsState({
    @Default(false) bool isLoading,
    @Default([]) List<UnitData> units,
    @Default(null) UnitData? selectedUnit,
    TextEditingController? unitController,
  }) = _CreateFoodUnitsState;

  const CreateFoodUnitsState._();
}
