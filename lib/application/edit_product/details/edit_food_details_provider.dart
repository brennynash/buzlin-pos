import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'edit_food_details_state.dart';
import 'edit_food_details_notifier.dart';

final editFoodDetailsProvider =
    StateNotifierProvider<EditFoodDetailsNotifier, EditFoodDetailsState>(
  (ref) => EditFoodDetailsNotifier(productsRepository, galleryRepository),
);
