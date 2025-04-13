import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'create_product_gallery_state.freezed.dart';

@freezed
class CreateProductGalleryState with _$CreateProductGalleryState{
  const factory CreateProductGalleryState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default([]) List<Extras> extras,
    @Default({}) Map<String, List<String?>> images,
    @Default({}) Map<String, List<Galleries?>> listOfUrls,
  }) = _CreateProductGallery;

  const CreateProductGalleryState._();
}
