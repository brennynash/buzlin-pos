import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../application/services/services_notifier.dart';
import 'services_state.dart';

final servicesProvider =
StateNotifierProvider<ServicesNotifier, ServicesState>(
      (ref) => ServicesNotifier(),
);
