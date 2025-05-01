import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/di/dependency_manager.dart';
import 'add_food_categories_state.dart';
import 'add_food_categories_notifier.dart';

final addFoodCategoriesProvider =
    StateNotifierProvider<AddFoodCategoriesNotifier, AddFoodCategoriesState>(
  (ref) => AddFoodCategoriesNotifier(categoriesRepository),
);
