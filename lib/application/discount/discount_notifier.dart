import 'dart:async';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'discount_state.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscountNotifier extends StateNotifier<DiscountState> {
  final DiscountsRepository _discountRepository;
  int _page = 0;

  DiscountNotifier(this._discountRepository) : super(const DiscountState());

  Future<void> fetchDiscounts({
    required BuildContext context,
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      _page = 0;
      state = state.copyWith(discounts: [], isLoading: true, hasMore: true);
    }
    final res = await _discountRepository.getAllDiscounts(page: ++_page);
    res.when(success: (data) {
      List<DiscountData> list = List.from(state.discounts);
      list.addAll(data.data ?? []);
      state = state.copyWith(isLoading: false, discounts: list, hasMore: list.length < (data.meta?.total ?? 0));
      if (isRefresh ?? false) {
        controller?.refreshCompleted();
        return;
      } else if (data.data?.isEmpty ?? true) {
        controller?.loadNoData();
        return;
      }
      controller?.loadComplete();
      return;
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.showSnackBar(context, failure);
    });
  }

  Future<void> deleteDiscount(BuildContext context, int? id) async {
    state = state.copyWith(isLoading: true);
    final response = await _discountRepository.deleteDiscount(id);
    response.when(
      success: (success) {
        List<DiscountData> list = List.from(state.discounts);
        list.removeWhere((element) => element.id == id);
        state = state.copyWith(discounts: list);
      },
      failure: (failure, status) {
        AppHelpers.showSnackBar(
          context,
          failure,
        );
      },
    );
    state = state.copyWith(isLoading: false);
  }
}
