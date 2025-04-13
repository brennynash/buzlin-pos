import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repository/repository.dart';
import '../../../../infrastructure/services/utils.dart';
import 'create_food_units_state.dart';

class CreateFoodUnitsNotifier extends StateNotifier<CreateFoodUnitsState> {
  final CategoriesRepository _catalogRepository;

  CreateFoodUnitsNotifier(this._catalogRepository)
      : super(CreateFoodUnitsState(unitController: TextEditingController()));

  void clearAll() {
    state.unitController?.clear();
    state = state.copyWith(selectedUnit: null);
  }

  Future<void> fetchUnits(BuildContext context) async {
    state = state.copyWith(selectedUnit: null);
    if (state.units.isNotEmpty) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final response = await _catalogRepository.getUnits();
    response.when(
      success: (data) {
        final List<UnitData> units = data.data ?? [];
        state = state.copyWith(units: units, isLoading: false);
      },
      failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        AppHelpers.showSnackBar(context, failure);
        debugPrint('====> fetch units fail $failure');
      },
    );
  }

  void setActiveIndex(UnitData unit) {
    if (state.selectedUnit?.id == unit.id) {
      return;
    }
    state = state.copyWith(selectedUnit: unit);
    state.unitController?.text = unit.translation?.title ?? '';
  }
}
