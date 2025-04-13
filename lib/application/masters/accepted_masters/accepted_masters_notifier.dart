import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'accepted_masters_state.dart';

class AcceptedMastersNotifier extends StateNotifier<AcceptedMastersState> {
  final UsersFacade _usersRepository;

  AcceptedMastersNotifier(this._usersRepository)
      : super(const AcceptedMastersState());
  int _page = 0;
  Timer? _searchMastersTimer;


  addList(UserData userData, BuildContext context) async {
    List<UserData> list = List.from(state.users);
    list.insert(0, userData);
    state = state.copyWith(users: list, totalCount: state.totalCount + 1);
    final response = await _usersRepository.updateMasterStatus(
      status: MasterStatus.acceptedMaster,
      id: userData.invitations?.first.id,
    );
    response.when(
      success: (data) {
        AppHelpers.showSnackBar(context,
            "#${userData.id} ${AppHelpers.getTranslation(
                TrKeys.orderStatusChanged)}",
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

  void setMastersQuery(BuildContext context, String query) {
    if (state.acceptedMastersQuery == query) {
      return;
    }
    state = state.copyWith(acceptedMastersQuery: query.trim());

    if (_searchMastersTimer?.isActive ?? false) {
      _searchMastersTimer?.cancel();
    }
    _searchMastersTimer = Timer(
      const Duration(milliseconds: 500),
          () async {
        state = state.copyWith(users: []);
        final response = await _usersRepository.searchUsers(
          role: TrKeys.master,
          inviteStatus: TrKeys.accepted,
          query: query
        );
        response.when(
          success: (data) {
            final List<UserData> users = data.users ?? [];
            List<DropDownItemData> tempDropDownUsers = [];
            for (int i = 0; i < users.length; i++) {
              tempDropDownUsers.add(
                DropDownItemData(
                  index: i,
                  id: users[i].id,
                  title: '${users[i].firstname} ${users[i].lastname ?? ""}',
                ),
              );
            }
            state = state.copyWith(
                isLoading: false,
                users: users,
                dropdownUsers: tempDropDownUsers,
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
      },
    );
  }

  Future<void> fetchMembers({
    bool isRefresh = false,
    int? serviceId,
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
      inviteStatus: TrKeys.accepted,
      serviceId: serviceId
    );
    response.when(
      success: (data) {
        List<UserData> list = List.from(state.users);
        list.addAll(data.users ?? []);
        List<DropDownItemData> tempDropDownUsers = [];
        for (int i = 0; i < list.length; i++) {
          tempDropDownUsers.add(
            DropDownItemData(
              index: i,
              id: list[i].id,
              title: '${list[i].firstname} ${list[i].lastname ?? ""}',
            ),
          );
        }
        state = state.copyWith(
            isLoading: false,
            users: list,
            totalCount: data.meta?.total ?? 0,
            hasMore: state.users.length != data.meta?.total,
          dropdownUsers: tempDropDownUsers,
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