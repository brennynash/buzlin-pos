import 'dart:convert';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import '../../di/dependency_manager.dart';
import '../../handlers/handlers.dart';
import '../../models/models.dart';
import '../../models/response/order_status_response.dart';
import '../bookings_repository.dart';

class BookingsRepositoryImpl implements BookingsFacade {
  @override
  Future<ApiResult<BookingsCalculateResponse>> calculateBooking({
    int? userId,
    DateTime? startDate,
    required Map<int, UserData> selectMasters,
  }) async {
    final data = {
      "data": [
        ...selectMasters.values.map(
              (e) => {
            "service_master_id": e.serviceMaster?.id,
            "start_date": TimeService.dateFormatYMDHm(e.time),
            // if (e.serviceMaster?.service?.selectExtras?.isNotEmpty ?? false)
            //   "service_extras": [
            //     ...?e.serviceMaster?.service?.selectExtras?.map((e) => e.id)
            //   ],
            // if (e.membership != null) "user_member_ship_id": e.membership?.id,
          },
        )
      ],
      "user_id": userId,
      "currency_id": LocalStorage.getSelectedCurrency()?.id,
      // "start_date": DateService.dateFormatYMDHm(startDate)
    };
    debugPrint('===> booking calculate request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/seller/bookings/calculate',
        data: data,
      );
      return ApiResult.success(
          data: BookingsCalculateResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> booking calculate failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<BookingResponse>> createBooking({
    int? userId,
    int? paymentId,
    DateTime? startDate,
    List<UserData>? serviceMasters,
  }) async {
    final data = {
      "data": [
        for (int i = 0; i < (serviceMasters?.length ?? 0); i++)
          {
            "service_master_id": serviceMasters?[i].serviceMaster?.id,
            "start_date":  TimeService.dateFormatYMDHm(serviceMasters?[i].time),
            if (serviceMasters?[i].note?.isNotEmpty ?? false)
              "note": serviceMasters?[i].note,
            if (serviceMasters?[i].address?.isNotEmpty ?? false)
              "address": serviceMasters?[i].address,
          }
      ],
      "user_id": userId,
      "payment_id": paymentId,
      "currency_id": LocalStorage.getSelectedCurrency()?.id,
      // "start_date": DateService.dateFormatYMDHm(startDate)
    };
    debugPrint('===> create booking request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/${AppHelpers.getUserRole}/bookings',
        data: data,
      );
      return ApiResult.success(data: BookingResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> create booking failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleBookingResponse>> updateBooking({
    required int? id,
    required int? userId,
    required ServiceData? serviceData,
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    final data = {
      "service_master_id": serviceData?.id,
      if (serviceData?.note?.isNotEmpty ?? false) "note": serviceData?.note,
      if (serviceData?.address?.isNotEmpty ?? false)
        "address": serviceData?.address,
      "currency_id": LocalStorage.getSelectedCurrency()?.id,
      "start_date": TimeService.dateFormatYMDHm(startDate),
      "end_date": TimeService.dateFormatYMDHm(endDate)
    };
    debugPrint('===> update booking request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.put(
        '/api/v1/dashboard/seller/bookings/$id',
        data: data,
      );
      return ApiResult.success(data: SingleBookingResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> update booking failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<BookingResponse>> getBookings({
    int? page,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? masterId,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (status != null) 'status': status,
      if (startDate != null) 'start_date': TimeService.dateFormatDay(startDate),
      if (endDate != null)
        'end_date': TimeService.dateFormatDay(endDate.addDay(1)),
      if (masterId != null) 'master_id': masterId,
      'perPage': 10,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/bookings',
        queryParameters: data,
      );
      return ApiResult.success(
        data: BookingResponse.fromJson(response.data),
      );
    } catch (e,s) {
      debugPrint('==> get bookings paginate failure: $e, $s');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleBookingResponse>> fetchSingleBooking(int? id) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/bookings/$id',
      );
      return ApiResult.success(
        data: SingleBookingResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> fetch single booking failure: $e, $s');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> deleteBooking(int? id) async {
    final data = {'ids[0]': id};
    debugPrint('====> delete booking request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/bookings/delete',
        queryParameters: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete booking failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<CheckTimeResponse>> checkTime({
    required DateTime start,
    required List<int> serviceId,
  }) async {
    final data = {
      "start_date": TimeService.dateFormatYMDHm(start),
      for (int i = 0; i < serviceId.length; i++)
        "service_master_ids[$i]": serviceId[i],
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.get('/api/v1/rest/master/times-all',
          queryParameters: data);
      return ApiResult.success(data: CheckTimeResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> check time failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<OrderStatusResponse>> updateBookingStatus(
      {required BookingStatus status, int? id}) async {
    String? statusText = status == BookingStatus.newOrder ? 'new' : status.name;
    final data = {'status': statusText};
    debugPrint('===> update booking status request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/seller/bookings/$id/status/update',
        data: data,
      );
      return ApiResult.success(data: OrderStatusResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> delete booking failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleBookingResponse>> updateBookingNotes({
    required int? id,
    required String? note,
  }) async {
    final data = {"note": note};
    debugPrint('===> update booking notes request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/seller/bookings/$id/notes/update',
        data: data,
      );
      return ApiResult.success(data: SingleBookingResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> update booking notes failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}
