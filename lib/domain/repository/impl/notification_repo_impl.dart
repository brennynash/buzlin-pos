import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/data/count_notifications_data.dart';
import 'package:admin_desktop/domain/models/data/notification_transactions_data.dart';
import 'package:admin_desktop/domain/models/data/read_one_notification_data.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<ApiResult<TransactionListResponse>> getTransactions(
      {int? page}) async {
    final data = {
      if (page != null) 'page': page,
      'perPage': 4,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'model': 'orders'
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.getUser()?.role}/transactions/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: TransactionListResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get getTransactions failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<NotificationResponse>> getNotifications({
    int? page,
  }) async {
    final data = {
      if (page != null) 'page': page,
      'column': 'created_at',
      'sort': 'desc',
      'perPage': 5,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/notifications',
        queryParameters: data,
      );
      return ApiResult.success(
        data: NotificationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<NotificationResponse>> readAll() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/notifications/read-all',
      );
      return ApiResult.success(
        data: NotificationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<ReadOneNotificationResponse>> readOne({int? id}) async {
    final data = {
      if (id != null) '$id': id,
      // 'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/notifications/$id/read-at',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ReadOneNotificationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<NotificationResponse>> showSingleUser({int? id}) async {
    final data = {
      if (id != null) '$id': id,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/notifications/$id',
        queryParameters: data,
      );
      return ApiResult.success(
        data: NotificationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<NotificationResponse>> getAllNotifications() async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/notifications',
        queryParameters: data,
      );
      return ApiResult.success(
        data: NotificationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CountNotificationData>> getCount() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/profile/notifications-statistic',
      );
      return ApiResult.success(
        data: CountNotificationData.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<bool>> deleteNotification({int? id}) async {
    try {
      final client = dioHttp.client(requireAuth: true);

      await client.delete('/api/v1/dashboard/notifications/$id');
      return const ApiResult.success(data: true);
    } catch (e) {
      debugPrint('==> delete notification failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
}
