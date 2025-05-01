import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_brand_state.dart';
import 'create_brand_notifier.dart';

final createBrandProvider =
    StateNotifierProvider<CreateBrandNotifier, CreateBrandState>(
  (ref) => CreateBrandNotifier(brandsRepository, galleryRepository),
);
