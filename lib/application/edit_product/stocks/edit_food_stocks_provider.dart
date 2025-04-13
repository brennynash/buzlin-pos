import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_food_stocks_state.dart';
import 'edit_food_stocks_notifier.dart';

final editFoodStocksProvider = StateNotifierProvider.autoDispose<
    EditFoodStocksNotifier, EditFoodStocksState>(
  (ref) => EditFoodStocksNotifier(productsRepository),
);
