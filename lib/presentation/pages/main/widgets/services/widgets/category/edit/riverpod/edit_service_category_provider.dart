import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_service_category_notifier.dart';
import 'edit_service_category_state.dart';

final editServiceCategoryProvider = StateNotifierProvider<
    EditServiceCategoryNotifier, EditServiceCategoryState>(
  (ref) => EditServiceCategoryNotifier(categoriesRepository, galleryRepository),
);
