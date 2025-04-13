import 'package:admin_desktop/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_categories_state.freezed.dart';

@freezed
class ServiceCategoriesState with _$ServiceCategoriesState {
  const factory ServiceCategoriesState({
    @Default(false) bool isLoading,
    @Default([]) List<CategoryData> categories,
    @Default(false) bool isAllSelect,
    @Default([]) List selectCategories,
    @Default([]) List<int> selectParents,
    @Default([]) List<int> selectSubs,
  }) = _ServiceCategoriesState;

  const ServiceCategoriesState._();
}
