import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/response/subscriptions_response.dart';
import 'package:admin_desktop/domain/models/response/transactions_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../subscription_repository.dart';

class SubscriptionsRepositoryImpl implements SubscriptionsRepository {
  @override
  Future<ApiResult<SubscriptionResponse>> getSubscriptions(
      {required int page}) async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/subscriptions',
        queryParameters: data,
      );
      return ApiResult.success(
          data: SubscriptionResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get subscription failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult> purchaseSubscription(
      {required int id, required int paymentId}) async {
    final data = {
      'payment_sys_id': paymentId,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/subscriptions/$id/attach',
        data: data,
      );
      return ApiResult.success(data: response.data['data']['id']);
    } catch (e) {
      debugPrint('==> purchase ads failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
  @override
  Future<ApiResult<TransactionsResponse>> createTransaction({
    required int id,
    required int paymentId,
  }) async {
    final data = {'payment_sys_id': paymentId};
    debugPrint('===> create transaction body: ${jsonEncode(data)}');
    debugPrint('===> create transaction subscriptions id: $id');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/payments/subscription/$id/transactions',
        data: data,
      );
      return ApiResult.success(
        data: TransactionsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create transaction failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          );
    }
  }
}
