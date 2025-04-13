import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'edit_category_notifier.dart';
import 'edit_category_state.dart';

final editCategoryProvider =
    StateNotifierProvider<EditCategoryNotifier, EditCategoryState>(
  (ref) => EditCategoryNotifier(categoriesRepository, galleryRepository),
);
