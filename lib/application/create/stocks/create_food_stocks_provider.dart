import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'create_food_stocks_state.dart';
import 'create_food_stocks_notifier.dart';

final createFoodStocksProvider =
    StateNotifierProvider<CreateFoodStocksNotifier, CreateFoodStocksState>(
  (ref) => CreateFoodStocksNotifier(productsRepository),
);
