import '../../domain/handlers/handlers.dart';
import '../../domain/models/response/subscriptions_response.dart';
import '../../domain/models/response/transactions_response.dart';

abstract class SubscriptionsRepository {
  Future<ApiResult<SubscriptionResponse>> getSubscriptions({required int page});

  Future<ApiResult> purchaseSubscription(
      {required int id, required int paymentId});
  Future<ApiResult<TransactionsResponse>> createTransaction({
    required int id,
    required int paymentId,
  });
}
