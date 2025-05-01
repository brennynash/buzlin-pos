import 'package:admin_desktop/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/repository.dart';
import '../../presentation/pages/main/widgets/profile/edit_shop/widget/transactions/web_view_page.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'subscriptions_state.dart';

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionsRepository _subscriptionRepository;
  final PaymentsFacade _paymentsRepo;

  int _page = 0;

  SubscriptionNotifier(this._subscriptionRepository, this._paymentsRepo)
      : super(const SubscriptionState());

  fetchSubscriptions({
    BuildContext? context,
    bool? isRefresh,
    RefreshController? controller,
  }) async {
    if (isRefresh ?? false) {
      controller?.resetNoData();
      _page = 0;
      state = state.copyWith(list: [], isLoading: true);
    }
    final res = await _subscriptionRepository.getSubscriptions(
      page: ++_page,
    );
    res.when(success: (data) {
      List<SubscriptionData> list = List.from(state.list);
      list.addAll(data.data ?? []);
      state = state.copyWith(isLoading: false, list: list);
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
      debugPrint(" ==> fetch ads fail: $failure");
      if (context != null) {
        AppHelpers.showSnackBar(context, failure);
      }
    });
  }

  Future<void> payment(
    BuildContext context, {
    required VoidCallback onSuccess,
    VoidCallback? failed,
  }) async {
    state = state.copyWith(isPaymentLoading: true);
    if ((state.payments?[state.selectPayment].tag ?? "") == 'wallet') {
      final num walletPrice =
          LocalStorage.getUser()?.wallet?.price ?? 0;
      final num orderPrice =
          state.list[state.selectSubscribe].price ?? 0;
      if (walletPrice < orderPrice) {
        AppHelpers.errorSnackBar(
          context,
          text: AppHelpers.getTranslation(TrKeys.notEnoughMoney),
        );
        state = state.copyWith(isPaymentLoading: false);
        return;
      }
      final res = await _subscriptionRepository.purchaseSubscription(
          id: state.list[state.selectSubscribe].id ?? 0,
          paymentId: state.payments?[state.selectPayment].id ?? 0);
      res.when(success: (success) async {
        final response = await _subscriptionRepository.createTransaction(
          id: success,
          paymentId: state.payments?[state.selectPayment].id ?? 0,
        );
        response.when(
          success: (success) {
            onSuccess.call();
            state = state.copyWith(isPaymentLoading: false);
          },
          failure: (failure, status) {
            state = state.copyWith(isPaymentLoading: false);
          },
        );
      }, failure: (failure, s) {
        state = state.copyWith(isPaymentLoading: false);
        AppHelpers.showSnackBar(context, failure);
      });
    } else {
      final res = await _paymentsRepo.paymentSubscriptionWebView(
        name: state.payments?[state.selectPayment].tag ?? "",
        subscriptionId: state.list[state.selectSubscribe].id ?? 0,
      );
      res.when(success: (data) async {
        state = state.copyWith(isPaymentLoading: false);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(url: data),
          ),
        );

      }, failure: (failure, s) {
        state = state.copyWith(isPaymentLoading: false);
        AppHelpers.showSnackBar(context, failure);
      });
    }
  }


  fetchPayments({required BuildContext context}) async {
    final res = await _paymentsRepo.getPayments();
    res.when(success: (data) {
      List<PaymentData> list = [];
      for (int i = 0; i < (data.data?.length ?? 0); i++) {
        if (data.data?[i].tag != "cash") {
          list.add(data.data?[i] ?? PaymentData());
        }
      }
      state = state.copyWith(payments: list, selectPayment: 0);
    }, failure: (failure, s) {
      AppHelpers.showSnackBar(context, failure);
    });
  }

  selectPayment({required int index}) {
    state = state.copyWith(selectPayment: index);
  }

  selectSubscribe({required int index}) {
    state = state.copyWith(selectSubscribe: index);
  }
}
