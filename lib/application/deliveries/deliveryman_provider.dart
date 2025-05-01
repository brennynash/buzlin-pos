import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'deliveryman_notifier.dart';
import 'deliveryman_state.dart';

final deliverymanProvider =
    StateNotifierProvider<DeliverymanNotifier, DeliverymanState>(
  (ref) => DeliverymanNotifier(usersRepository),
);
