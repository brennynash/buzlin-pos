import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/data/gift_card_data.dart';
part 'gift_card_state.freezed.dart';

@freezed
class GiftCardState with _$GiftCardState {
  const factory GiftCardState({
    @Default(false) bool isLoading,
    @Default([]) List<GiftCardData> list,
    @Default(true) bool hasMore,
  }) = _GiftCardState;

  const GiftCardState._();
}
