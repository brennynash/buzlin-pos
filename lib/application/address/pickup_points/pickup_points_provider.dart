import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pickup_points_notifier.dart';
import 'pickup_points_state.dart';

final pickupPointsProvider =
    StateNotifierProvider<PickupPointsNotifier, PickupPointsState>(
  (ref) => PickupPointsNotifier(addressRepository),
);
