import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'create_product_gallery_state.dart';
import 'create_product_gallery_notifier.dart';

final createProductGalleryProvider = StateNotifierProvider.autoDispose<
    CreateProductGalleryNotifier, CreateProductGalleryState>(
  (ref) => CreateProductGalleryNotifier(productsRepository, galleryRepository),
);
