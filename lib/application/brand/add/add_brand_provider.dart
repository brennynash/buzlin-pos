import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'add_brand_notifier.dart';
import 'add_brand_state.dart';

final addBrandProvider =
    StateNotifierProvider<AddBrandNotifier, AddBrandState>(
  (ref) => AddBrandNotifier(brandsRepository, galleryRepository),
);
