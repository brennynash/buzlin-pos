import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'create_category_parent_state.dart';

class CreateCategoryParentNotifier
    extends StateNotifier<CreateCategoryParentState> {

  CreateCategoryParentNotifier()
      : super(
          const CreateCategoryParentState(),
        );

  void setSelectCategory(CategoryData category) {
    if (state.selectCategory?.id == category.id) {
      return;
    }
    state = state.copyWith(selectCategory: category,oldCategory: null);
  }

  void setActiveIndex(CategoryData category) {
    List<CategoryData> list = List.from(state.selectCategories);
    List<TextEditingController> controllers =
    List.from(state.categoryControllers);
    CategoryData? selectCategory = state.selectCategory;
    if (list.isNotEmpty) {
      int index =
      list.indexWhere((element) => element.parentId == category.parentId);
      if (category.parentId == null) {
        index = 0;
      }
      if (index != -1) {
        list.removeRange(index, list.length);
        controllers.removeRange(index, controllers.length);
        if (category.children?.isNotEmpty ?? true) {
          selectCategory = null;
        }
      }
    }

    list.add(category);
    if (category.type == "sub_main" ) {
      selectCategory = category;
    }
    controllers.add(TextEditingController(
        text: category.translation?.title ??
            AppHelpers.getTranslation(TrKeys.noName)));
    state = state.copyWith(
      selectCategories: list,
      categoryControllers: controllers,
      selectCategory: selectCategory,
    );
    if (category.children?.isEmpty ?? true) {
      setSelectCategory(category);
    }
  }

  void setCategories(List<CategoryData> categories) {
    if (state.categories.isEmpty) {
      state = state.copyWith(
        categories: categories,
        selectCategory: null,
        selectCategories: [],
        categoryControllers: [],
        oldCategory: categories.isEmpty ? null : state.oldCategory,
      );
    } else {
      state = state.copyWith(
        selectCategory: null,
        selectCategories: [],
        categoryControllers: [],
      );
    }
  }
}
