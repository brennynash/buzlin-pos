import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_service_category_state.dart';
import 'create_service_category_notifier.dart';

final createServiceCategoryProvider = StateNotifierProvider<
    CreateServiceCategoryNotifier, CreateServiceCategoryState>(
  (ref) =>
      CreateServiceCategoryNotifier(categoriesRepository, galleryRepository),
);
