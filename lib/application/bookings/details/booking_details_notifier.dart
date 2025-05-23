import 'package:admin_desktop/domain/repository/bookings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'booking_details_state.dart';

class BookingDetailsNotifier extends StateNotifier<BookingDetailsState> {
  final BookingsFacade _bookingRepository;

  BookingDetailsNotifier(this._bookingRepository)
      : super(const BookingDetailsState());

  Future<void> fetchBookingDetails({
    required BuildContext context,
    required BookingData bookingData,
    ValueChanged<BookingData?>? onSuccess,
  }) async {
    state = state.copyWith(isLoading: true, bookingData: bookingData);
    final res = await _bookingRepository.fetchSingleBooking(bookingData.id);
    res.when(success: (data) {
      state = state.copyWith(isLoading: false, bookingData: data.data);
      onSuccess?.call(data.data);
    }, failure: (failure, status) {
      state = state.copyWith(isLoading: false);
      AppHelpers.errorSnackBar(context, text: failure);
    });
  }

  Future<void> updateBooking(
    BuildContext context, {
    required UserData? selectedMaster,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isUpdating: true);
    final response = await _bookingRepository.updateBooking(
      id: state.bookingData?.id,
      userId: state.bookingData?.userId,
      startDate: state.bookingData?.startDate,
      endDate: state.bookingData?.endDate,
      serviceData: selectedMaster?.serviceMaster,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isUpdating: false, bookingData: data.data);
        success?.call();
      },
      failure: (failure, status) {
        debugPrint('===> update booking failure: $failure');
        state = state.copyWith(isUpdating: false);
        AppHelpers.errorSnackBar(context, text: failure);
      },
    );
  }

  setBookingDetail(BookingData? bookingData, {VoidCallback? success}) {
    state = state.copyWith(afterUpdatedBookingData: bookingData);
    success?.call();
  }

  Future<void> updateBookingNotes(
    BuildContext context, {
    required String note,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isUpdateNote: true);
    final response = await _bookingRepository.updateBookingNotes(
      note: note,
      id: state.bookingData?.id,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isUpdateNote: false, bookingData: data.data);
        success?.call();
        fetchBookingDetails(context: context, bookingData: data.data ?? BookingData());
      },
      failure: (failure, status) {
        debugPrint('===> update booking status failure: $failure');
        state = state.copyWith(isUpdateNote: false);
        AppHelpers.errorSnackBar(context, text: failure);
      },
    );
  }

  Future<void> updateBookingStatus(
    BuildContext context, {
    required BookingStatus status,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isUpdating: true);
    final response = await _bookingRepository.updateBookingStatus(
      status: status,
      id: state.bookingData?.id,
    );
    response.when(
      success: (data) {
        state = state.copyWith(
            isUpdating: false,
            bookingData:
                state.bookingData?.copyWith(status: data.data?.status));
        success?.call();
      },
      failure: (failure, status) {
        debugPrint('===> update booking status failure: $failure');
        state = state.copyWith(isUpdating: false);
        AppHelpers.errorSnackBar(context, text: failure);
      },
    );
  }
}
