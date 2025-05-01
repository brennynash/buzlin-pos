import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'edit_product_gallery_state.dart';
import 'edit_product_gallery_notifier.dart';

final editProductGalleryProvider = StateNotifierProvider.autoDispose<
    EditProductGalleryNotifier, EditProductGalleryState>(
  (ref) => EditProductGalleryNotifier(productsRepository,galleryRepository),
);
