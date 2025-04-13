import 'package:admin_desktop/infrastructure/services/utils.dart';

import '../handlers/handlers.dart';
import '../models/models.dart';
import '../models/response/order_status_response.dart';

abstract class BookingsFacade {
  Future<ApiResult<BookingsCalculateResponse>> calculateBooking({
    int? userId,
    DateTime? startDate,
    required Map<int, UserData> selectMasters,
  });

  Future<ApiResult<BookingResponse>> createBooking({
    int? userId,
    int? paymentId,
    DateTime? startDate,
    List<UserData>? serviceMasters,
  });

  Future<ApiResult<SingleBookingResponse>> updateBooking({
    required int? id,
    required int? userId,
    required ServiceData? serviceData,
    required DateTime? startDate,
    required DateTime? endDate,
  });

  Future<ApiResult<BookingResponse>> getBookings({
    int? page,
    DateTime? startDate,
    DateTime? endDate,
    int? masterId,
    String? status,
  });

  Future<ApiResult<SingleBookingResponse>> fetchSingleBooking(int? id);

  Future<ApiResult<OrderStatusResponse>> updateBookingStatus({
    required BookingStatus status,
    int? id,
  });

  Future<ApiResult> deleteBooking(int? id);

  Future<ApiResult<CheckTimeResponse>> checkTime({
    required DateTime start,
    required List<int> serviceId,
  });

  Future<ApiResult<SingleBookingResponse>> updateBookingNotes({
    required int? id,
    required String? note,
  });
}

