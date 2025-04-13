import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'order_user_state.dart';
import 'order_user_notifier.dart';

final orderUserProvider =
    StateNotifierProvider<OrderUserNotifier, OrderUserState>(
  (ref) => OrderUserNotifier(usersRepository),
);
