import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/repository.dart';
import '../../presentation/pages/main/widgets/profile/edit_shop/widget/transactions/web_view_page.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'wallet_state.dart';

class WalletNotifier extends StateNotifier<WalletState> {
  final UsersFacade _userRepository;
  final WalletRepository _paymentsRepo;
  int page = 0;
  int searchPage = 0;

  WalletNotifier(this._userRepository, this._paymentsRepo)
      : super(const WalletState());

  fetchTransactions(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller}) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      page = 0;
      state = state.copyWith(transactions: [], isTransactionLoading: true, hasMore: true);
    }
    final res = await _userRepository.getTransactions(++page);
    res.when(success: (data) {
      List<TransactionModel> list = List.from(state.transactions);
      list.addAll(data.data ?? []);
      state = state.copyWith(isTransactionLoading: false, transactions: list, hasMore: list.length < (data.meta?.total ?? 0));
      if (isRefresh ?? false) {
        controller?.refreshCompleted();
        return;
      } else if (data.data?.isEmpty ?? true) {
        controller?.loadNoData();
        return;
      }
      controller?.loadComplete();
      return;
    }, failure: (failure, s) {
      if (isRefresh ?? false) {
        controller?.refreshFailed();
        return;
      }
      controller?.loadFailed();
      state = state.copyWith(isTransactionLoading: false);
      AppHelpers.showSnackBar(context, failure);
    });
  }

  searchUser(
      {required BuildContext context,
      bool? isRefresh,
      RefreshController? controller,
      required String search}) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      searchPage = 0;
      state = state.copyWith(listOfUser: [], isSearchingLoading: true);
    }

    final res =
        await _userRepository.searchUsers(query: search);
    res.when(success: (data) {
      List<UserData> list = List.from(state.listOfUser ?? []);
      list.addAll(data.users ?? []);
      state = state.copyWith(listOfUser: list, isSearchingLoading: false);
      if (isRefresh ?? false) {
        controller?.refreshCompleted();
        return;
      } else if (data.users?.isEmpty ?? true) {
        controller?.loadNoData();
        return;
      }
      controller?.loadComplete();
      return;
    }, failure: (failure, s) {
      state = state.copyWith(isSearchingLoading: false);
      if (isRefresh ?? false) {
        controller?.refreshFailed();
        return;
      }
      controller?.loadFailed();
      AppHelpers.showSnackBar(context, failure);
    });
  }

  fetchPayments({required BuildContext context}) async {
    final res = await _paymentsRepo.getPayments();
    res.when(success: (data) {
      List<PaymentData> list = [];
      for (int i = 0; i < (data.data?.length ?? 0); i++) {
        if (data.data?[i].tag != "cash" && data.data?[i].tag != "wallet") {
          list.add(data.data?[i] ?? PaymentData());
        }
      }
      state = state.copyWith(list: list, selectPayment: 0);
    }, failure: (failure, s) {
      AppHelpers.showSnackBar(context,  failure);
    });
  }

  selectPayment({required int index}) {
    state = state.copyWith(selectPayment: index);
  }

  fillWallet(
      {required BuildContext context,
      required int walletId,
      required VoidCallback onSuccess,
      required String price}) async {
    state = state.copyWith(isButtonLoading: true);
    final res = await _paymentsRepo.paymentWalletWebView(
        name: state.list?[state.selectPayment].tag ?? "",
        walletId: walletId,
        price: double.tryParse(price) ?? 0);
    res.when(success: (data) async {
      state = state.copyWith(isButtonLoading: false);
      WebViewPage(url: data);
    }, failure: (failure, s) {
      state = state.copyWith(isButtonLoading: false);
      AppHelpers.showSnackBar(context,  failure);
    });
  }

  sendWallet(
      {required BuildContext context,
      required String price,
      required VoidCallback onSuccess,
      required String uuid}) async {
    state = state.copyWith(isButtonLoading: true);
    final res = await _paymentsRepo.sendWallet(
        uuid: uuid, price: double.tryParse(price) ?? 0);
    res.when(success: (data) async {
      state = state.copyWith(isButtonLoading: false);
      onSuccess();
    }, failure: (failure, s) {
      state = state.copyWith(isButtonLoading: false);
      AppHelpers.showSnackBar(context, failure);
    });
  }
}
