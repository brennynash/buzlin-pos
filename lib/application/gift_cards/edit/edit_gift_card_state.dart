import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_desktop/domain/models/data/gift_card_data.dart';
part 'edit_gift_card_state.freezed.dart';

@freezed
class EditGiftCardState with _$EditGiftCardState {
  const factory EditGiftCardState({
    @Default(false) bool isLoading,
    @Default(true) bool active,
    GiftCardData? giftCardData,
  }) = _EditGiftCardState;

  const EditGiftCardState._();
}
