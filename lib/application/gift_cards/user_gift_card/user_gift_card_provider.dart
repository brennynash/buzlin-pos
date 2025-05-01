import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'user_gift_card_state.dart';
import 'user_gift_card_notifier.dart';

final userGiftCardProvider =
    StateNotifierProvider<UserGiftCardNotifier, UserGiftCardState>(
  (ref) => UserGiftCardNotifier(giftCardRepository),
);
