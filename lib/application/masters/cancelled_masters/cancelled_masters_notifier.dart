import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'cancelled_masters_state.dart';

class CancelledMastersNotifier extends StateNotifier<CancelledMastersState> {
  final UsersFacade _usersRepository;

  CancelledMastersNotifier(this._usersRepository) : super(const CancelledMastersState());
  int _page = 0;

  addList(UserData userData, BuildContext context) async {
    List<UserData> list = List.from(state.users);
    list.insert(0, userData);
    state = state.copyWith(users: list, totalCount: state.totalCount + 1);
    final response = await _usersRepository.updateMasterStatus(
      status: MasterStatus.cancelledMaster,
      id: userData.invitations?.first.id,
    );
    response.when(
      success: (data) {
        AppHelpers.showSnackBar(context,
            "#${userData.id} ${AppHelpers.getTranslation(TrKeys.orderStatusChanged)}",
            isIcon: true);
      },
      failure: (failure, status) {
        debugPrint('===> update order status fail $failure');
        AppHelpers.showSnackBar(context,
            AppHelpers.getTranslation(TrKeys.somethingWentWrongWithTheServer));
      },
    );
  }

  removeList(int index) {
    List<UserData> list = List.from(state.users);
    list.removeAt(index);
    state = state.copyWith(users: list, totalCount: state.totalCount - 1);
  }

  Future<void> fetchMembers({
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      _page = 0;
      state = state.copyWith(users: [], isLoading: true);
    }
    if (!state.hasMore && !isRefresh) {
      state = state.copyWith(isLoading: false);
      return;
    }
    final response = await _usersRepository.searchUsers(
      page: ++_page,
      role: TrKeys.master,
      inviteStatus: TrKeys.canceled,
    );
    response.when(
      success: (data) {
        List<UserData> list = List.from(state.users);
        list.addAll(data.users ?? []);
        state = state.copyWith(
            isLoading: false,
            users: list,
            totalCount: data.meta?.total ?? 0,
            hasMore: state.users.length != data.meta?.total
        );
      },
      failure: (failure, status) {
        _page--;
        if (_page == 0) {
          state = state.copyWith(isLoading: false);
        }
      },
    );
  }
}
