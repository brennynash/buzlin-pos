import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/presentation/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/data/notification_transactions_data.dart';
import '../../domain/models/models.dart' hide TransactionModel;
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'notification_state.dart';

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _notificationRepository;

  int _page = 0;
  int _notificationPage = 0;

  NotificationNotifier(this._notificationRepository)
      : super(const NotificationState());

  Future<void> fetchAllTransactions({
    bool isRefresh = false,
    Function(int)? updateTotal,
  }) async {
    if (isRefresh) {
      _page = 0;
      state = state.copyWith(hasMoreTransactions: true);
    }
    if (!state.hasMoreTransactions) {
      return;
    }
    state = state.copyWith(
        isTransactionsLoading: state.transaction.isEmpty ? true : false);
    final response =
        await _notificationRepository.getTransactions(page: ++_page);
    response.when(
      success: (data) {
        List<TransactionModel> transactions =
            isRefresh ? [] : List.from(state.transaction);
        final List<TransactionModel> newTransactions = data.data ?? [];
        transactions.addAll(newTransactions);
        state =
            state.copyWith(hasMoreTransactions: newTransactions.length >= 4);
        if (_page == 1 && !isRefresh) {
          state = state.copyWith(
            isTransactionsLoading: false,
            transaction: transactions,
          );
        } else {
          state = state.copyWith(
            isTransactionsLoading: false,
            transaction: transactions,
          );
        }
      },
      failure: (failure, status) {
        _page--;
        if (_page == 0) {
          state = state.copyWith(isTransactionsLoading: false);
        }
      },
    );
  }

  changeFirst() {
    state =
        state.copyWith(isFirstTimeNotification: true, isFirstTransaction: true);
  }

  Future<void> fetchAllNotifications(BuildContext context) async {
    state = state.copyWith(isNotificationLoading: true);

    final response = await _notificationRepository.getAllNotifications();
    response.when(
      success: (data) {
        state = state.copyWith(
            isNotificationLoading: false, notifications: data.data ?? []);
      },
      failure: (failure, status) {
        AppHelpers.showSnackBar(context, failure.toString());
      },
    );
  }

  Future<void> fetchNotificationsPaginate({
    VoidCallback? checkYourNetwork,
  }) async {
    if (!state.hasMoreNotification) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_notificationPage == 0) {
        state = state.copyWith(isNotificationLoading: true, notifications: []);

        final response = await notificationRepository.getNotifications(
          page: ++_notificationPage,
        );
        response.when(
          success: (data) {
            state = state.copyWith(
              notifications: data.data ?? [],
              isNotificationLoading: false,
            );
            if ((data.data?.length ?? 0) < 5) {
              state = state.copyWith(hasMoreNotification: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isNotificationLoading: false);
            debugPrint('==> get products failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreNotificationLoading: true);
        final response = await notificationRepository.getNotifications(
          page: ++_notificationPage,
        );
        response.when(
          success: (data) async {
            final List<NotificationModel> newList =
                List.from(state.notifications);
            newList.addAll(data.data ?? []);
            state = state.copyWith(
              notifications: newList,
              isMoreNotificationLoading: false,
            );
            if ((data.data?.length ?? 0) < 5) {
              state = state.copyWith(hasMoreNotification: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isMoreNotificationLoading: false);
            debugPrint('==> get notifications more failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> readAll(BuildContext context) async {
    List<NotificationModel> notif = List.from(state.notifications);
    for (var i = 0; i < notif.length; i++) {
      if (notif[i].readAt == null) {
        notif[i] = notif[i].copyWith(readAt: DateTime.now());
      }
    }
    state = state.copyWith(
      notifications: notif,
      countOfNotifications:
          state.countOfNotifications?.copyWith(notification: 0),
    );
    updateTotal();

    final response = await _notificationRepository.readAll();
    response.when(
      success: (data) {
        debugPrint('Read all success');
      },
      failure: (failure, status) {
        AppHelpers.showSnackBar(context, failure.toString());
      },
    );
  }

  Future<void> readOne(BuildContext context,
      {int? id, required int index}) async {
    List<NotificationModel> notif = List.from(state.notifications);
    notif[index] = notif[index].copyWith(
      readAt: DateTime.now(),
    );
    final notification = state.countOfNotifications?.copyWith(
        notification: (state.countOfNotifications?.notification ?? 0) - 1);
    state = state.copyWith(
        notifications: notif, countOfNotifications: notification);
    updateTotal();
    final response = await _notificationRepository.readOne(id: id);
    response.when(
      success: (data) {
        debugPrint('Success read one');
      },
      failure: (failure, status) {
        AppHelpers.showSnackBar(context, failure.toString());
      },
    );
  }

  Future<void> fetchCount(BuildContext context) async {
    final response = await _notificationRepository.getCount();
    response.when(
      success: (data) {
        state = state.copyWith(countOfNotifications: data);
        state = state.copyWith(
            totalCount: (data.notification ?? 0) + (data.transaction ?? 0));

        debugPrint('Success count');
      },
      failure: (failure, status) {
        if (status == 401) {
          context.pushRoute(LoginRoute());
          LocalStorage.clearStore();
        }
        AppHelpers.showSnackBar(context, failure);
      },
    );
  }

  updateTotal() {
    state = state.copyWith(
        totalCount: (state.countOfNotifications?.notification ?? 0) +
            (state.countOfNotifications?.transaction ?? 0));
  }

  Future<void> deleteNotification({required int? id}) async {
    List<NotificationModel> list = List.from(state.notifications);
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        list.removeAt(i);
      }
    }
    state = state.copyWith(notifications: list);
    final response = await _notificationRepository.deleteNotification(id: id);
    response.when(
      success: (data) {
        debugPrint('Success delete');
      },
      failure: (failure, status) {
        debugPrint('delete notification fail: $failure');
      },
    );
  }
}
