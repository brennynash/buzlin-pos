import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/di/dependency_manager.dart';
import 'create_food_units_state.dart';
import 'create_food_units_notifier.dart';

final createFoodUnitsProvider =
    StateNotifierProvider<CreateFoodUnitsNotifier, CreateFoodUnitsState>(
  (ref) => CreateFoodUnitsNotifier(categoriesRepository),
);
