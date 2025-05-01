import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'comments_state.dart';


class CommentsNotifier extends StateNotifier<CommentsState> {
  final CommentsRepository _commentsRepository;
  int _page = 0;
  int _shopPage = 0;

  CommentsNotifier(this._commentsRepository) : super(const CommentsState());

  void setActiveIndex(int index) {
    if (state.activeIndex == index) {
      return;
    }
    state = state.copyWith(activeIndex: index);
  }

  fetchProductComments({
    BuildContext? context,
    bool? isRefresh,
  }) async {
    if (isRefresh ?? false) {
      _page = 0;
      state = state.copyWith(hasMoreProductComment: true, productComments: [], isLoading: true);
    }
    if (!state.hasMoreProductComment) {
      return;
    }
    if(_page == 0){
      final res = await _commentsRepository.getProductComments(
        page: ++_page,
      );
      res.when(success: (data) {
        List<CommentsData> list = List.from(state.productComments);
        list.addAll(data.data ?? []);
        state = state.copyWith(isLoading: false, productComments: list);

        if ((data.data?.length ?? 0) < 12) {
          state = state.copyWith(hasMoreProductComment: false);
        }
      }, failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        if (context != null) {
          AppHelpers.showSnackBar(context, failure);
        }      });
    }
    else{
      state = state.copyWith(isLoading: true);
      final res =
      await _commentsRepository.getProductComments(page: ++_page);
      res.when(success: (data) {
        List<CommentsData> list = List.from(state.productComments);
        list.addAll(data.data ?? []);
        state = state.copyWith(isLoading: false, productComments: list);
        if ((data.data?.length ?? 0) < 12) {
          state = state.copyWith(hasMoreProductComment: false);
        }
      }, failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        if (context != null) {
          AppHelpers.showSnackBar(context, failure);
        }      });
    }

  }

  void changeState(int index) {
    state = state.copyWith(stateIndex: index);
  }
  fetchShopComments({
    BuildContext? context,
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      _shopPage = 0;
      state = state.copyWith(hasMore: true, shopComments: [], isLoading: true);
    }
    if (!state.hasMore) {
      return;
    }
    if(_shopPage == 0){
      final res = await _commentsRepository.getShopComments(page: ++_shopPage);
      res.when(success: (data) {
        List<ShopCommentsData> list = List.from(state.shopComments);
        list.addAll(data.data ?? []);
        state = state.copyWith(isLoading: false, shopComments: list);

        if ((data.data?.length ?? 0) < 12) {
          state = state.copyWith(hasMore: false);
        }
      }, failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        if(context != null){
          AppHelpers.showSnackBar(context, status.toString());
        }
      });
    }
    else{
      state = state.copyWith(isLoading: true);
      final res =
      await _commentsRepository.getShopComments(page: ++_shopPage);
      res.when(success: (data) {
        List<ShopCommentsData> list = List.from(state.shopComments);
        list.addAll(data.data ?? []);
        state = state.copyWith(isLoading: false, shopComments: list);
        if ((data.data?.length ?? 0) < 12) {
          state = state.copyWith(hasMore: false);
        }
      }, failure: (failure, status) {
        state = state.copyWith(isLoading: false);
        if(context != null){
          AppHelpers.showSnackBar(context, status.toString());
        }
      });
    }
  }
  changeSelectProductComment(int index) {
    if (index == state.selectedProductComment) {
      state = state.copyWith(selectedProductComment: -1);
    } else {
      state = state.copyWith(selectedProductComment: index);
    }
  }

  changeSelectShopComment(int index) {
    if (index == state.selectedShopComment) {
      state = state.copyWith(selectedShopComment: -1);
    } else {
      state = state.copyWith(selectedShopComment: index);
    }
  }
}
