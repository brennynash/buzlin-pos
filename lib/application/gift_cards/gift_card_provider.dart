import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'gift_card_state.dart';
import 'gift_card_notifier.dart';

final giftCardProvider =
    StateNotifierProvider<GiftCardNotifier, GiftCardState>(
  (ref) => GiftCardNotifier(giftCardRepository),
);
