import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sale_history_notifier.dart';
import 'sale_history_state.dart';

final saleHistoryProvider =
    StateNotifierProvider<SaleHistoryNotifier, SaleHistoryState>(
  (ref) => SaleHistoryNotifier(settingsRepository),
);
