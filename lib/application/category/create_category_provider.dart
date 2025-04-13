import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/di/dependency_manager.dart';
import 'create_category_state.dart';
import 'create_category_notifier.dart';

final createCategoryProvider =
    StateNotifierProvider<CreateCategoryNotifier, CreateCategoryState>(
  (ref) => CreateCategoryNotifier(categoriesRepository, galleryRepository),
);
