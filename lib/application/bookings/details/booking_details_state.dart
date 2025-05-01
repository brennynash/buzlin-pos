import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_desktop/domain/models/models.dart';

part 'booking_details_state.freezed.dart';

@freezed
class BookingDetailsState with _$BookingDetailsState {
  const factory BookingDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool isUpdating,
    BookingData? bookingData,
    BookingData? afterUpdatedBookingData,
    @Default(false) bool isUpdateNote,
  }) = _BookingDetailsState;

  const BookingDetailsState._();
}
