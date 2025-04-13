import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'add_discount_notifier.dart';
import 'add_discount_state.dart';

final addDiscountProvider =
    StateNotifierProvider<AddDiscountNotifier, AddDiscountState>(
  (ref) => AddDiscountNotifier(discountRepository, settingsRepository),
);
