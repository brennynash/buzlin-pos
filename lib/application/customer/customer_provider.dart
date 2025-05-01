import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'customer_notifier.dart';
import 'customer_state.dart';

final customerProvider =
    StateNotifierProvider<CustomerNotifier, CustomerState>(
  (ref) => CustomerNotifier(
    usersRepository,
    settingsRepository
  ),
);
