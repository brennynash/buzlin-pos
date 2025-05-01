
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shop_socials_notifier.dart';
import 'shop_socials_state.dart';

final shopSocialsProvider =
    StateNotifierProvider.autoDispose<ShopSocialsNotifier, ShopSocialsState>(
  (ref) => ShopSocialsNotifier(shopsRepository),
);
