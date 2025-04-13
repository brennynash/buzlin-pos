import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_desktop/domain/models/data/gift_card_data.dart';
part 'add_gift_card_state.freezed.dart';

@freezed
class AddGiftCardState with _$AddGiftCardState {
  const factory AddGiftCardState({
    @Default(false) bool isLoading,
    GiftCardData? giftCardData,
    @Default(true) bool active,
  }) = _AddGiftCardState;

  const AddGiftCardState._();
}
