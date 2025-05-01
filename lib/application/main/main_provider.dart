import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'main_notifier.dart';
import 'main_state.dart';

final mainProvider = StateNotifierProvider<MainNotifier, MainState>(
  (ref) => MainNotifier(
    productsRepository,
    categoriesRepository,
    brandsRepository,
    usersRepository,
    shopsRepository
  ),
);
