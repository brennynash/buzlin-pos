import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repository/repository.dart';
import '../../../../infrastructure/services/utils.dart';
import 'add_food_categories_state.dart';

class AddFoodCategoriesNotifier extends StateNotifier<AddFoodCategoriesState> {
  final CategoriesRepository _catalogRepository;
  int _page = 0;

  AddFoodCategoriesNotifier(this._catalogRepository)
      : super(
          AddFoodCategoriesState(categoryController: TextEditingController()),
        );

  void clearAll() {
    state.categoryController?.clear();
    state = state.copyWith(selectCategory: null);
  }

  Future<void> updateCategories(BuildContext context) async {
    _page = 0;
    final response = await _catalogRepository.getCategories(page: ++_page);
    response.when(
      success: (data) {
        List<CategoryData> categories = List.from(state.categories);
        final List<CategoryData> newCategories = data.data ?? [];
        for (final category in newCategories) {
          bool contains = false;
          for (final oldCategory in categories) {
            if (category.id == oldCategory.id) {
              contains = true;
            }
          }
          if (!contains) {
            categories.insert(0, category);
          }
        }
        state = state.copyWith(categories: categories, selectCategory: null);
        if (categories.isNotEmpty) {
          state.categoryController?.text =
              state.categories[0].translation?.title ?? '';
        }
      },
      failure: (failure, status) {
        debugPrint('====> fetch categories fail $failure');
        _page--;
        AppHelpers.showSnackBar(context, failure);
      },
    );
  }

  void setActiveCategory(CategoryData category) {
    if (state.selectCategory?.id == category.id) {
      return;
    }
    state = state.copyWith(selectCategory: category, oldCategory: null);
    state.categoryController?.text = category.translation?.title ?? '';
  }
  void setActiveIndex(CategoryData category) {
    List<CategoryData> list = List.from(state.selectCategories);
    List<TextEditingController> controllers =
    List.from(state.categoryControllers);
    CategoryData? selectCategory = state.selectCategory;
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
    list.add(category);
    if (category.children?.isEmpty ?? true) {
      selectCategory = category;
    }
    controllers
        .add(TextEditingController(text: category.translation?.title ?? ''));
    state.categoryController?.text = '';
    state = state.copyWith(
      selectCategories: list,
      categoryControllers: controllers,
      selectCategory: selectCategory,
      oldCategory: null,
    );
  }

  // void setActiveIndex(CategoryData category) {
  //   List<CategoryData> list = List.from(state.selectCategories);
  //   List<TextEditingController> controllers =
  //   List.from(state.categoryControllers);
  //   CategoryData? selectCategory = state.selectCategory;
  //   if (list.length > 1) {
  //     int index =
  //     list.indexWhere((element) => element.parentId == category.parentId);
  //     if (index != -1) {
  //       list.removeRange(index, list.length);
  //       controllers.removeRange(index, controllers.length);
  //       if (category.children?.isNotEmpty ?? true) {
  //         selectCategory = null;
  //       }
  //     }
  //   }
  //   list.add(category);
  //
  //   controllers
  //       .add(TextEditingController(text: category.translation?.title ?? ''));
  //   state = state.copyWith(
  //     selectCategories: list,
  //     categoryControllers: controllers,
  //     selectCategory: selectCategory,
  //   );
  // }


  void setSelectCategory(CategoryData category) {
    if (state.selectCategory?.id == category.id) {
      return;
    }
    state = state.copyWith(selectCategory: category);
  }

  void setCategories(List<CategoryData> categories) {
    state = state.copyWith(selectCategory: null);
    if (state.categories.isEmpty) {
      _page = 0;
      state = state.copyWith(
        categories: categories,
        oldCategory: categories.isEmpty ? null : state.oldCategory,
      );
      if (categories.isNotEmpty) {
        state.categoryController?.text =
            state.categories[0].translation?.title ?? '';
      }
    }
  }
}
