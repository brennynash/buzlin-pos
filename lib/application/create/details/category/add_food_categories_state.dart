import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_food_categories_state.freezed.dart';

@freezed
class AddFoodCategoriesState with _$AddFoodCategoriesState {
  const factory AddFoodCategoriesState({
    @Default([]) List<CategoryData> categories,
    @Default(null) CategoryData? selectCategory,
    TextEditingController? categoryController,
    @Default([]) List<CategoryData> selectCategories,
    @Default(false) bool isLoading,
    CategoryData? oldCategory,
    @Default([]) List<TextEditingController> categoryControllers,
  }) = _AddFoodCategoriesState;

  const AddFoodCategoriesState._();
}
