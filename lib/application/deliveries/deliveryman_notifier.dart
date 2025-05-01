import 'dart:async';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'deliveryman_state.dart';

class DeliverymanNotifier extends StateNotifier<DeliverymanState> {
  final UsersFacade _usersRepository;

  DeliverymanNotifier(this._usersRepository) : super(const DeliverymanState());
  int _page = 0;
  Timer? _timer;
  String _query = '';

  Future<void> fetchDeliverymen({
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      _page = 0;
      state = state.copyWith(users: [], isLoading: true, hasMore: true);
    }
    final response = await _usersRepository.searchUsers(
      page: ++_page,
      role: TrKeys.deliveryman,
      query: _query
    );
    response.when(
      success: (data) {
        List<UserData> list = List.from(state.users);
        list.addAll(data.users ?? []);
        state = state.copyWith(
          isLoading: false,
          users: list,
          hasMore: list.length < (data.meta?.total ?? 0)
        );
        if (isRefresh) {
          return;
        } else if (data.users?.isEmpty ?? true) {
          return;
        }
        return;
      },
      failure: (failure, status) {
        debugPrint('====> fetch deliverymen fail $failure');
      },
    );
  }

  void setQuery({
    required String query,
  }) {
    if (_query == query) {
      return;
    }
    _query = query.trim();
    if (_query.isNotEmpty) {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(
        const Duration(milliseconds: 500),
        () {
          fetchDeliverymen(isRefresh: true);
        },
      );
    } else {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(
        const Duration(milliseconds: 500),
        () {
          fetchDeliverymen(isRefresh: true);
        },
      );
    }
  }

  addCreatedUser(UserData? user) {
    if (user == null) return;
    List<UserData> users = List.from(state.users);
    users.add(user);
    state = state.copyWith(users: users);
  }

  void setStatusIndex(int? index) {
    state = state.copyWith(statusIndex: index ?? 0);
  }
  Future<void> updateStatus({
    required int? id,
    required String status,
    ValueChanged<int>? onSuccess,
  }) async {
    state=state.copyWith(isUpdate:true);
    final response = await _usersRepository.updateStatus(
      id: id,
      status: status,
    );
    response.when(
      success: (data) {
        state = state.copyWith(statusIndex: -1,isUpdate:false);
        final List statuses = [
          TrKeys.newKey,
          TrKeys.accepted,
          TrKeys.canceled,
          TrKeys.rejected
        ];
        onSuccess?.call(statuses.indexOf(status));
      },
      failure: (failure, status) {
        state=state.copyWith(isUpdate:false);
        debugPrint('===> update master status fail $failure');
      },
    );
  }
}
