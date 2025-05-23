import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/models.dart';
part 'booking_state.freezed.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState({
    @Default(false) bool isLoading,
    @Default([]) List<BookingData> bookings,
    @Default(-1) int selectMaster,
    @Default(0) int calendarType,
    @Default(0) int stateIndex,
    @Default(null) String? status,
    @Default(2.2) double calendarZoom,
    @Default(null) DateTime? startDate,
    @Default(null) DateTime? endDate,
    @Default(true) bool hasMore,
  }) = _BookingState;

  const BookingState._();
}
