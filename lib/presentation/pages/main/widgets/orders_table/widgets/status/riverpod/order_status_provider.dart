import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../../../domain/di/dependency_manager.dart';
import 'order_status_notifier.dart';
import 'order_status_state.dart';

final orderStatusProvider =
    StateNotifierProvider<OrderStatusNotifier, OrderStatusState>(
  (ref) => OrderStatusNotifier(ordersRepository),
);
