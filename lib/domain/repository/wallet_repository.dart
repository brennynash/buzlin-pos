import '../../domain/handlers/handlers.dart';
import '../../domain/models/response/non_exist_payment_response.dart';
import '../../domain/models/response/payments_response.dart';

abstract class WalletRepository {
  Future<ApiResult<PaymentsResponse>> getPayments();

  Future<ApiResult<NonExistPaymentResponse>> getNonExistPayments();


  Future<ApiResult<String>> paymentWalletWebView(
      {required String name, required int walletId, required num price});

  Future<ApiResult<bool>> sendWallet(
      {required String uuid, required num price});
}
