import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'convert_notifier.dart';
import 'convert_state.dart';

final convertProvider = StateNotifierProvider.autoDispose<ConvertNotifier, ConvertState>(
  (ref) => ConvertNotifier(productsRepository),
);
