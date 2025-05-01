import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_units_state.dart';
import 'edit_food_units_notifier.dart';

final editFoodUnitsProvider =
    StateNotifierProvider<EditFoodUnitsNotifier, EditFoodUnitsState>(
  (ref) => EditFoodUnitsNotifier(categoriesRepository),
);
