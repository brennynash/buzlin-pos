import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_desktop/domain/models/models.dart';
part 'create_booking_state.freezed.dart';

@freezed
class CreateBookingState with _$CreateBookingState {
  const factory CreateBookingState({
    @Default(false) bool isLoading,
    @Default(false) bool isPaymentLoading,
    @Default(false) bool isButtonLoading,
    @Default(false) bool isUserLoading,
    @Default(null) BookingCalculateData? calculate,
    @Default(null) DateTime? selectDateTime,
    @Default(null) String? selectBookTime,
    @Default(null) String? selectUserError,
    @Default(null) UserData? selectUser,
    @Default(-1) int selectPayment,
    @Default([]) List<CheckData>? listDate,
    @Default([]) List<PaymentData>? payments,
    @Default([]) List<ServiceData> services,
    @Default([]) List<ServiceData> selectServices,
    @Default('') String usersQuery,
    @Default([]) List<UserData> users,
    @Default({}) Map<int, UserData> selectMasters,
    @Default([]) List<DropDownItemData> dropdownUsers,
    UserData? selectedUser,
  }) = _CreateBookingState;

  const CreateBookingState._();
}
