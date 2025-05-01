import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'food_categories_state.dart';

class FoodCategoriesNotifier extends StateNotifier<FoodCategoriesState> {
  final CategoriesRepository _catalogRepository;
  int _page = 0;
  bool _hasMore = true;

  FoodCategoriesNotifier(this._catalogRepository)
      : super(const FoodCategoriesState());

  Future<void> initialFetchCategories() async {
    _page = 0;
    _hasMore = true;
    state = state.copyWith(categories: [], isLoading: true);
    final response = await _catalogRepository.getCategories(page: ++_page);
    response.when(
      success: (data) {
        final List<CategoryData> categories = data.data ?? [];
        _hasMore = categories.length == data.meta?.total;
        state = state.copyWith(categories: categories, isLoading: false);
      },
      failure: (failure, status) {
        debugPrint('====> initial fetch categories fail $failure');
        _page--;
        state = state.copyWith(isLoading: false);
      },
    );
  }

  updateCategories(CategoryData? category) {
    if (category == null) {
      return;
    }
    final List<CategoryData> categories = List.from(state.categories);
    categories.removeWhere((element) => element.id == category.id);
    categories.add(category);
    state = state.copyWith(categories: categories, isLoading: false);
  }

  addCategories(CategoryData? category) {
    if (category == null) {
      return;
    }
    final List<CategoryData> categories = List.from(state.categories);
    categories.add(category);
    state = state.copyWith(categories: categories, isLoading: false);
  }

  Future<void> fetchCategories({
    required BuildContext context,
    RefreshController? refreshController,
    bool openingPage = false,
  }) async {
    if (openingPage) {
      if (state.categories.isNotEmpty) {
        return;
      }
    }
    if (!_hasMore) {
      refreshController?.loadNoData();
      return;
    }
    if (_page == 0) {
      state = state.copyWith(isLoading: true);
    }
    final response = await _catalogRepository.getCategories(page: ++_page);
    response.when(
      success: (data) {
        List<CategoryData> categories = List.from(state.categories);
        final List<CategoryData> newCategories = data.data ?? [];
        categories.addAll(newCategories);
        _hasMore = newCategories.length >= 10;
        if (_page == 1) {
          state = state.copyWith(isLoading: false, categories: categories);
        } else {
          state = state.copyWith(categories: categories);
        }
        refreshController?.loadComplete();
      },
      failure: (failure, status) {
        debugPrint('====> fetch categories fail $failure');
        _page--;
        if (_page == 0) {
          state = state.copyWith(isLoading: false);
        }
        AppHelpers.showSnackBar(context, failure.toString());
        refreshController?.loadFailed();
      },
    );
  }

  // void allSelectOrder(List<CategoryData> orderList) {
  //   List list = [];
  //   if (!state.isAllSelect) {
  //     for (int i = 0; i < orderList.length; i++) {
  //       list.add(orderList[i].id);
  //     }
  //     state = state.copyWith(isAllSelect: true);
  //   } else {
  //     state = state.copyWith(isAllSelect: false);
  //   }
  //   state = state.copyWith(selectCategories: list);
  // }

  void addSelectOrder({int? id, required int orderLength}) {
    List<int> list = List.from(state.selectCategories);
    if (state.selectCategories.contains(id)) {
      list.remove(id);
    } else {
      list.add(id ?? 0);
    }
    state = state.copyWith(selectCategories: list);

    if (list.length == orderLength) {
      state = state.copyWith(isAllSelect: true);
    } else {
      state = state.copyWith(isAllSelect: false);
    }
  }

  onTapParent(int? id) {
    if (id == null) {
      return;
    }
    List<int> list = List.from(state.selectParents);
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    state = state.copyWith(selectParents: list, selectSubs: []);
  }

  onTapSub(int? id) {
    if (id == null) {
      return;
    }
    List<int> list = List.from(state.selectSubs);
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    state = state.copyWith(selectSubs: list);
  }
}
