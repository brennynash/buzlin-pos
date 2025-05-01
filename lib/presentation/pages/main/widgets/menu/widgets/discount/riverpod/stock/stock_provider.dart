import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../../domain/di/dependency_manager.dart';
import 'stock_state.dart';
import 'stock_notifier.dart';

final stockProvider = StateNotifierProvider<StockNotifier, StockState>(
  (ref) => StockNotifier(stockRepository),
);
