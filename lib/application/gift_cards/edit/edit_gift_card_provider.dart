import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'edit_gift_card_notifier.dart';
import 'edit_gift_card_state.dart';

final editGiftCardProvider =
    StateNotifierProvider<EditGiftCardNotifier, EditGiftCardState>(
  (ref) => EditGiftCardNotifier(giftCardRepository),
);
