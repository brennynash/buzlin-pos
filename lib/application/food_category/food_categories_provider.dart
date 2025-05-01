import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'food_categories_state.dart';
import 'package:admin_desktop/application/food_category/food_categories_notifier.dart';

final foodCategoriesProvider =
    StateNotifierProvider<FoodCategoriesNotifier, FoodCategoriesState>(
  (ref) => FoodCategoriesNotifier(categoriesRepository),
);
