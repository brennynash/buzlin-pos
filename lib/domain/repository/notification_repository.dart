import '../../domain/handlers/handlers.dart';
import '../../domain/models/data/count_notifications_data.dart';
import '../../domain/models/data/notification_data.dart';
import '../../domain/models/data/notification_transactions_data.dart';
import '../../domain/models/data/read_one_notification_data.dart';

abstract class NotificationRepository {
  Future<ApiResult<TransactionListResponse>> getTransactions({
    int? page,
  });

  Future<ApiResult<NotificationResponse>> getNotifications({
    int? page,
  });

  Future<ApiResult<NotificationResponse>> getAllNotifications();

  Future<ApiResult<ReadOneNotificationResponse>> readOne({
    int? id,
  });

  Future<ApiResult<NotificationResponse>> readAll();

  Future<ApiResult<NotificationResponse>> showSingleUser({
    int? id,
  });

  Future<ApiResult<CountNotificationData>> getCount();
  Future<ApiResult<bool>> deleteNotification({int? id});

}
