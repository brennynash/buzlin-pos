import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/response/non_exist_payment_response.dart';
import 'package:admin_desktop/domain/models/response/payments_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../wallet_repository.dart';


class WalletRepositoryImpl implements WalletRepository {
  @override
  Future<ApiResult<PaymentsResponse>> getPayments() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get('/api/v1/rest/payments',
          queryParameters: {
            "lang": LocalStorage.getLanguage()?.locale ?? 'en'
          });
      return ApiResult.success(
        data: PaymentsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get payments error: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<NonExistPaymentResponse>> getNonExistPayments() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
          '/api/v1/dashboard/seller/shop-payments/shop-non-exist',
          queryParameters: {
            "lang": LocalStorage.getLanguage()?.locale ?? 'en'
          });
      return ApiResult.success(
        data: NonExistPaymentResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get non exist payments error: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
      );
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
  Future<ApiResult<bool>> sendWallet(
      {required String uuid, required num price}) async {
    try {
      final data = {
        'uuid': uuid,
        'price': price,
        "currency_id": LocalStorage.getSelectedCurrency()?.id
      };
      final client = dioHttp.client(requireAuth: true);
      await client.post('/api/v1/dashboard/user/wallet/send', data: data);
      return const ApiResult.success(data: true);
    } catch (e) {
      debugPrint('==> send wallet failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
      );
    }
  }
}
