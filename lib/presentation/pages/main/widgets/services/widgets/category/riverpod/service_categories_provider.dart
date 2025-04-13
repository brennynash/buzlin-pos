import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'service_categories_state.dart';
import 'service_categories_notifier.dart';

final serviceCategoriesProvider =
    StateNotifierProvider<ServiceCategoriesNotifier, ServiceCategoriesState>(
  (ref) => ServiceCategoriesNotifier(categoriesRepository),
);
