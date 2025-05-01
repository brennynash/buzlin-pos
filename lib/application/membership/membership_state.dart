import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/models.dart';

part 'membership_state.freezed.dart';

@freezed
class MembershipState with _$MembershipState {
  const factory MembershipState({
    @Default(false) bool isLoading,
    @Default(false) bool isPaymentLoading,
    @Default(true) bool hasMore,
    @Default(1) int selectPayment,
    @Default(0) int selectSubscribe,
    @Default([]) List<MembershipData> list,
    @Default([]) List<PaymentData>? payments,
  }) = _MembershipState;

  const MembershipState._();
}
