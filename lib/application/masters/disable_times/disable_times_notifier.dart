import 'package:admin_desktop/domain/repository/masters_repository.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'disable_times_state.dart';

class MasterDisableTimesNotifier
    extends StateNotifier<MasterDisableTimesState> {
  final MastersRepository _mastersRepository;

  MasterDisableTimesNotifier(this._mastersRepository)
      : super(const MasterDisableTimesState());
  String? _endValue;
  String? _customRepeatValue;
  String? _customRepeatType;

  setRepeats(String repeats) {
    state = state.copyWith(
      disableTime: state.disableTime?.copyWith(repeats: repeats),
    );
  }

  setEndType(String endType) {
    state = state.copyWith(
      disableTime: state.disableTime?.copyWith(endType: endType),
    );
  }

  setTimeTo(String? value) {
    state = state.copyWith(
      disableTime: state.disableTime?.copyWith(to: value),
    );
  }

  setTimeFrom(String? value) {
    state = state.copyWith(
      disableTime: state.disableTime?.copyWith(from: value),
    );
  }

  setDateTime(DateTime? value) {
    state = state.copyWith(
      disableTime: state.disableTime?.copyWith(date: value),
    );
  }

  clearAll() {
    DisableTimes disableTime = DisableTimes(
      repeats: DropDownValues.repeatsList.first,
      endType: DropDownValues.endTypeList.first,
      customRepeatType: DropDownValues.customRepeatType.first,
    );
    state = state.copyWith(
      disableTime: disableTime,
      isLoading: false,
      isUpdate: false,
    );
  }

  setEndDate(DateTime? value) => _endValue = TimeService.dateFormatDay(value);

  setEndValue(String value) => _endValue = value;

  setCustomRepeatValue(String value) => _customRepeatValue = value;

  setCustomRepeatType(String value) => _customRepeatType = value;

  fetchDisableTimeDetails(
    BuildContext context, {
    required DisableTimes? disableTime,
  }) async {
    state = state.copyWith(
        disableTime: disableTime, isLoading: true, isUpdate: false);
    final res = await _mastersRepository.getDisableTimeDetails(disableTime?.id);
    res.when(success: (data) {
      state = state.copyWith(isLoading: false, disableTime: data.data);
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.errorSnackBar(context, text: failure);
    });
  }

  Future<void> updateDisableTimeDetails({
    required String title,
    required String desc,
    VoidCallback? updateSuccess,
  }) async {
    state = state.copyWith(isUpdate: true);
    final response = await _mastersRepository.updateDisableTimes(
      time: state.disableTime!.copyWith(
        translation: Translation(
          title: title,
          description: desc,
        ),
        customRepeatValue: (_customRepeatValue?.isNotEmpty ?? false)
            ? [_customRepeatValue!]
            : null,
        endValue: _endValue,
        customRepeatType: _customRepeatType
      ),
      id: state.disableTime?.id,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isUpdate: false);
        updateSuccess?.call();
      },
      failure: (failure, status) {
        state = state.copyWith(isUpdate: false);
        debugPrint('==> error update disable times days $failure');
      },
    );
  }

  Future<void> addDisableTimes({
    required String title,
    required String desc,
    VoidCallback? createdSuccess,
  }) async {
    state = state.copyWith(isUpdate: true);
    final response = await _mastersRepository.updateDisableTimes(
      time: state.disableTime?.copyWith(
          translation: Translation(
            title: title,
            description: desc,
          ),
          customRepeatValue: (_customRepeatValue?.isNotEmpty ?? false)
              ? [_customRepeatValue!]
              : null,
          endValue: _endValue,
          customRepeatType: _customRepeatType) ?? DisableTimes(),
      id: state.disableTime?.id,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isUpdate: false);
        createdSuccess?.call();
      },
      failure: (failure, status) {
        state = state.copyWith(isUpdate: false);
        debugPrint('==> error update disable times days $failure');
      },
    );
  }
}
