import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'booking_details_notifier.dart';
import 'booking_details_state.dart';

final bookingDetailsProvider =
    StateNotifierProvider<BookingDetailsNotifier, BookingDetailsState>(
  (ref) => BookingDetailsNotifier(bookingRepository),
);
