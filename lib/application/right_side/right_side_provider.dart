import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/di/dependency_manager.dart';
import 'right_side_notifier.dart';
import 'right_side_state.dart';

final rightSideProvider =
StateNotifierProvider<RightSideNotifier, RightSideState>(
        (ref) => RightSideNotifier(
        usersRepository,
        currenciesRepository,
        paymentsRepository,
        productsRepository,
        ordersRepository,
        addressRepository
        ),
);
