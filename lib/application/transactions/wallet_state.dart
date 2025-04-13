
import 'package:admin_desktop/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'wallet_state.freezed.dart';

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    @Default(false) bool isTransactionLoading,
    @Default(false) bool isButtonLoading,
    @Default(false) bool isSearchingLoading,
    @Default(true) bool hasMore,
    @Default(1) int selectPayment,
    @Default([]) List<TransactionModel> transactions,
    @Default([]) List<PaymentData>? list,
    @Default([]) List<UserData>? listOfUser,
  }) = _WalletState;
}
