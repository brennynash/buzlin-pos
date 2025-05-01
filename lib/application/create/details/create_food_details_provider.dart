import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'create_food_details_state.dart';
import 'create_food_details_notifier.dart';

final createFoodDetailsProvider =
    StateNotifierProvider<CreateFoodDetailsNotifier, CreateFoodDetailsState>(
  (ref) => CreateFoodDetailsNotifier(productsRepository, galleryRepository),
);
