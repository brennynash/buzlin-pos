import 'package:admin_desktop/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'food_categories_state.freezed.dart';

@freezed
class FoodCategoriesState with _$FoodCategoriesState {
  const factory FoodCategoriesState({
    @Default(false) bool isLoading,
    @Default([]) List<CategoryData> categories,
    @Default(false) bool isAllSelect,
    @Default([]) List selectCategories,
    @Default([]) List<int> selectParents,
    @Default([]) List<int> selectSubs,
  }) = _FoodCategoriesState;

  const FoodCategoriesState._();
}
