import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'brand_notifier.dart';
import 'brand_state.dart';

final brandProvider = StateNotifierProvider<BrandNotifier, BrandState>(
  (ref) => BrandNotifier(brandsRepository),

);
