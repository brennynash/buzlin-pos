import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/data/user_gift_card_data.dart';
part 'user_gift_card_state.freezed.dart';

@freezed
class UserGiftCardState with _$UserGiftCardState {
  const factory UserGiftCardState({
    @Default(false) bool isLoading,
    @Default([]) List<UserGiftCardData> list,
    @Default(true) bool hasMore,
  }) = _UserGiftCardState;

  const UserGiftCardState._();
}
