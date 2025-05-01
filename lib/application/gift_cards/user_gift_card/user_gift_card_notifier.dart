import 'package:admin_desktop/domain/repository/gift_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:admin_desktop/domain/models/data/user_gift_card_data.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'user_gift_card_state.dart';

class UserGiftCardNotifier extends StateNotifier<UserGiftCardState> {
  final GiftCardRepository _giftCardRepository;

  int _page = 0;

  UserGiftCardNotifier(this._giftCardRepository)
      : super(const UserGiftCardState());

  fetchUserGiftCards({
    BuildContext? context,
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      _page = 0;
      state = state.copyWith(list: [], isLoading: true, hasMore: true);
    }
    final res = await _giftCardRepository.getUserGiftCards(
      page: ++_page,
    );
    res.when(success: (data) {
      List<UserGiftCardData> list = List.from(state.list);
      list.addAll(data.data ?? []);
      state = state.copyWith(isLoading: false,
          list: list,
          hasMore: list.length < (data.meta?.total ?? 0));
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
      debugPrint(" ==> fetch user gift card fail: $failure");
      if (context != null) {
        AppHelpers.errorSnackBar(context, text: failure);
      }
    });
  }
}
