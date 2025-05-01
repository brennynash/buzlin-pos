import '../../domain/handlers/handlers.dart';
import '../../domain/models/models.dart';

abstract class PaymentsFacade {
  Future<ApiResult<PaymentsResponse>> getPayments();

  Future<ApiResult<TransactionsResponse>> createTransaction({
    required int orderId,
    required int paymentId,
    int? deliveryPriceId
  });
  Future<ApiResult<String>> paymentWalletWebView(
      {required String name, required int walletId, required num price});
  Future<ApiResult<String>> paymentSubscriptionWebView(
      {required String name, required int subscriptionId});
}