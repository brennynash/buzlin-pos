import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class PaymentsRepositoryImpl extends PaymentsFacade {
  @override
  Future<ApiResult<PaymentsResponse>> getPayments() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get('/api/v1/rest/payments');

      return ApiResult.success(
        data: PaymentsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get payments failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<TransactionsResponse>> createTransaction({
    required int orderId,
    required int paymentId,
    int? deliveryPriceId
  }) async {
    final data = {'payment_sys_id': paymentId};
    debugPrint('===> create transaction body: ${jsonEncode(data)}');
    debugPrint('===> create transaction order id: $orderId');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/payments/order/$orderId/transactions',
        data: data,
      );
      return ApiResult.success(
        data: TransactionsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create transaction failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
  @override
  Future<ApiResult<String>> paymentWalletWebView(
      {required String name, required int walletId, required num price}) async {
    try {
      final data = {
        'wallet_id': walletId,
        'total_price': price,
        "currency_id": LocalStorage.getSelectedCurrency()?.id
      };

      final client = dioHttp.client(requireAuth: true);
      final res =
      await client.post('/api/v1/dashboard/user/$name-process', data: data);

      return ApiResult.success(data: res.data["data"]["data"]["url"] ?? "");
    } catch (e) {
      debugPrint('==> web view wallet failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          );
    }
  }

  @override
  Future<ApiResult<String>> paymentSubscriptionWebView(
      {required String name, required int subscriptionId}) async {
    try {
      final data = {
        'subscription_id': subscriptionId,
        "currency_id": LocalStorage.getSelectedCurrency()?.id
      };

      final client = dioHttp.client(requireAuth: true);
      final res = await client
          .post('/api/v1/dashboard/user/$name-process', data: data);

      return ApiResult.success(data: res.data["data"]["data"]["url"] ?? "");
    } catch (e) {
      debugPrint('==> web view wallet failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
         );
    }
  }
}
