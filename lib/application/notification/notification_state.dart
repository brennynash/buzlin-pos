import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/data/count_notifications_data.dart';
import '../../domain/models/data/notification_transactions_data.dart';
import '../../domain/models/models.dart' hide TransactionModel;
part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default([]) List<TransactionModel> transaction,
    @Default(0) int totalCount,
    @Default(false) bool isTransactionsLoading,
    @Default(true) bool hasMoreTransactions,
    @Default([]) List<NotificationModel> notifications,
    @Default(null) CountNotificationData? countOfNotifications,
    @Default(0) int totalCountNotification,
    @Default(false) bool isNotificationLoading,
    @Default(false) bool isMoreNotificationLoading,
    @Default(true) bool hasMoreNotification,
    @Default(false) bool isReadAllLoading,
    @Default(false) bool isShowUserLoading,
    @Default(false) bool isAllNotificationsLoading,
    @Default(false) bool isFirstTimeNotification,
    @Default(false) bool isFirstTransaction,
    @Default(0) int total,
  }) = _NotificationState;

  const NotificationState._();
}
