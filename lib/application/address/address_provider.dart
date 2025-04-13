import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'address_notifier.dart';
import 'address_state.dart';

final addressProvider = StateNotifierProvider<AddressNotifier, AddressState>(
  (ref) => AddressNotifier(addressRepository),
);
