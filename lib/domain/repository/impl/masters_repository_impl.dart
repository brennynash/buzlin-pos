import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../di/dependency_manager.dart';
import '../../handlers/handlers.dart';
import '../../models/models.dart';
import '../../models/response/profile_response.dart';
import '../masters_repository.dart';

class MastersRepositoryImpl implements MastersRepository {
  @override
  Future<ApiResult<UsersPaginateResponse>> getMasters({
    String? query,
    String? inviteStatus,
    int? page,
    int? serviceId,
  }) async {
    final data = {
      if (query?.isNotEmpty ?? false) 'search': query,
      'perPage': 10,
      if (page != null) 'page': page,
      'sort': 'desc',
      'column': 'created_at',
      if (inviteStatus != null) 'invite_status': inviteStatus,
      'role': "master",
      if (serviceId != null) 'service_id': serviceId,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        serviceId != null
            ? '/api/v1/rest/masters'
            : '/api/v1/dashboard/seller/shop/users/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UsersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search users failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> updateMasterStatus({
    required int? id,
    required String status,
  }) async {
    final data = {'status': status};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/shops/invites/$id/status/change',
        data: data,
      );
      return ApiResult.success(
        data: response.data,
      );
    } catch (e) {
      debugPrint('==> update master status failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> updateMaster(UserData? user) async {
    final data = {
      "firstname": user?.firstname,
      "lastname": user?.lastname,
      "phone": user?.phone,
      "gender": user?.gender,
      "img": user?.img,
    };
    debugPrint('===> update master info ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/users/${user?.uuid}',
        data: data,
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update master info failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> getMastersDetails(String? uuid) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/users/$uuid',
      );
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<void>> updateClosedDays(
      {required List<DateTime> days, int? masterId}) async {
    final data = {
      for (int i = 0; i < days.length; i++)
        'dates': days.map((e) => TimeService.dateFormatDay(e)).toList(),
      "master_id": masterId
    };
    debugPrint('====> update master closed days ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.put(
        '/api/v1/dashboard/seller/master-closed-dates/$masterId',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update master closed days failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<void>> updateDisableTimes({
    required DisableTimes time,
    int? id,
  }) async {
    final data = {
      'master_id': time.masterId,
      'title': {
        LocalStorage.getLanguage()?.locale ?? 'en': time.translation?.title
      },
      'description': {
        LocalStorage.getLanguage()?.locale ?? 'en':
            time.translation?.description
      },
      'from': time.from,
      'to': time.to,
      'date': time.date,
      'repeats': time.repeats,
      if (time.repeats == 'custom') 'custom_repeat_type': time.customRepeatType,
      if (time.repeats == 'custom')
        'custom_repeat_value': time.customRepeatValue,
      'end_type': time.endType,
      if (time.endType != 'never') 'end_value': time.endValue,
      'can_booking': (time.canBooking ?? true) ? 1 : 0,
    };
    debugPrint('====> update master closed days ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.put(
        '/api/v1/dashboard/seller/master-disabled-times/$id',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update master closed days failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ClosedDatesResponse>> getClosedDays({
    int? masterId,
    DateTime? to,
    DateTime? from,
  }) async {
    final data = {
      'master_id': masterId,
      if (to != null) 'date_to': TimeService.dateFormatDay(to),
      if (from != null) 'date_from': TimeService.dateFormatDay(from),
    };
    debugPrint('====> get closed days body: ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.get(
        '/api/v1/dashboard/seller/master-closed-dates/',
        queryParameters: data,
      );
      return ApiResult.success(data: ClosedDatesResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> get closed days failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<DisableTimesResponse>> getDisableTimes(
      {int? masterId, int? page}) async {
    final data = {
      'master_ids': [masterId],
      if (page != null) 'page': page,
      'perPage': 10
    };
    debugPrint('====> get closed days body: ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.get(
        '/api/v1/dashboard/seller/master-disabled-times',
        queryParameters: data,
      );
      return ApiResult.success(data: DisableTimesResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> get closed days failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleDisableTimeResponse>> getDisableTimeDetails(
      int? id) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.get(
        '/api/v1/dashboard/seller/master-disabled-times/$id',
      );
      return ApiResult.success(
        data: SingleDisableTimeResponse.fromJson(res.data),
      );
    } catch (e) {
      debugPrint('==> get closed days failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<void>> updateWorkingDays({
    required List<WorkingDay> workingDays,
    int? id,
  }) async {
    List<Map<String, dynamic>> days = [];
    for (final workingDay in workingDays) {
      final data = {
        'day': workingDay.day,
        'from': workingDay.from?.replaceAll('-', ':'),
        'to': workingDay.to?.replaceAll('-', ':'),
        'disabled': workingDay.disabled ?? false
      };
      days.add(data);
    }

    final data = {'dates': days, 'user_id': id};
    debugPrint('====> update master working days ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.put(
        '/api/v1/dashboard/seller/user-working-days/$id ',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update master working days failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }
}
