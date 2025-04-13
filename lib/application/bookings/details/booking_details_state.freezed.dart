// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingDetailsState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isUpdating => throw _privateConstructorUsedError;
  BookingData? get bookingData => throw _privateConstructorUsedError;
  BookingData? get afterUpdatedBookingData =>
      throw _privateConstructorUsedError;
  bool get isUpdateNote => throw _privateConstructorUsedError;

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingDetailsStateCopyWith<BookingDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDetailsStateCopyWith<$Res> {
  factory $BookingDetailsStateCopyWith(
          BookingDetailsState value, $Res Function(BookingDetailsState) then) =
      _$BookingDetailsStateCopyWithImpl<$Res, BookingDetailsState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isUpdating,
      BookingData? bookingData,
      BookingData? afterUpdatedBookingData,
      bool isUpdateNote});
}

/// @nodoc
class _$BookingDetailsStateCopyWithImpl<$Res, $Val extends BookingDetailsState>
    implements $BookingDetailsStateCopyWith<$Res> {
  _$BookingDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isUpdating = null,
    Object? bookingData = freezed,
    Object? afterUpdatedBookingData = freezed,
    Object? isUpdateNote = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpdating: null == isUpdating
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
      bookingData: freezed == bookingData
          ? _value.bookingData
          : bookingData // ignore: cast_nullable_to_non_nullable
              as BookingData?,
      afterUpdatedBookingData: freezed == afterUpdatedBookingData
          ? _value.afterUpdatedBookingData
          : afterUpdatedBookingData // ignore: cast_nullable_to_non_nullable
              as BookingData?,
      isUpdateNote: null == isUpdateNote
          ? _value.isUpdateNote
          : isUpdateNote // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingDetailsStateImplCopyWith<$Res>
    implements $BookingDetailsStateCopyWith<$Res> {
  factory _$$BookingDetailsStateImplCopyWith(_$BookingDetailsStateImpl value,
          $Res Function(_$BookingDetailsStateImpl) then) =
      __$$BookingDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isUpdating,
      BookingData? bookingData,
      BookingData? afterUpdatedBookingData,
      bool isUpdateNote});
}

/// @nodoc
class __$$BookingDetailsStateImplCopyWithImpl<$Res>
    extends _$BookingDetailsStateCopyWithImpl<$Res, _$BookingDetailsStateImpl>
    implements _$$BookingDetailsStateImplCopyWith<$Res> {
  __$$BookingDetailsStateImplCopyWithImpl(_$BookingDetailsStateImpl _value,
      $Res Function(_$BookingDetailsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isUpdating = null,
    Object? bookingData = freezed,
    Object? afterUpdatedBookingData = freezed,
    Object? isUpdateNote = null,
  }) {
    return _then(_$BookingDetailsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpdating: null == isUpdating
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
      bookingData: freezed == bookingData
          ? _value.bookingData
          : bookingData // ignore: cast_nullable_to_non_nullable
              as BookingData?,
      afterUpdatedBookingData: freezed == afterUpdatedBookingData
          ? _value.afterUpdatedBookingData
          : afterUpdatedBookingData // ignore: cast_nullable_to_non_nullable
              as BookingData?,
      isUpdateNote: null == isUpdateNote
          ? _value.isUpdateNote
          : isUpdateNote // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BookingDetailsStateImpl extends _BookingDetailsState {
  const _$BookingDetailsStateImpl(
      {this.isLoading = false,
      this.isUpdating = false,
      this.bookingData,
      this.afterUpdatedBookingData,
      this.isUpdateNote = false})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isUpdating;
  @override
  final BookingData? bookingData;
  @override
  final BookingData? afterUpdatedBookingData;
  @override
  @JsonKey()
  final bool isUpdateNote;

  @override
  String toString() {
    return 'BookingDetailsState(isLoading: $isLoading, isUpdating: $isUpdating, bookingData: $bookingData, afterUpdatedBookingData: $afterUpdatedBookingData, isUpdateNote: $isUpdateNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDetailsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUpdating, isUpdating) ||
                other.isUpdating == isUpdating) &&
            (identical(other.bookingData, bookingData) ||
                other.bookingData == bookingData) &&
            (identical(
                    other.afterUpdatedBookingData, afterUpdatedBookingData) ||
                other.afterUpdatedBookingData == afterUpdatedBookingData) &&
            (identical(other.isUpdateNote, isUpdateNote) ||
                other.isUpdateNote == isUpdateNote));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isUpdating,
      bookingData, afterUpdatedBookingData, isUpdateNote);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDetailsStateImplCopyWith<_$BookingDetailsStateImpl> get copyWith =>
      __$$BookingDetailsStateImplCopyWithImpl<_$BookingDetailsStateImpl>(
          this, _$identity);
}

abstract class _BookingDetailsState extends BookingDetailsState {
  const factory _BookingDetailsState(
      {final bool isLoading,
      final bool isUpdating,
      final BookingData? bookingData,
      final BookingData? afterUpdatedBookingData,
      final bool isUpdateNote}) = _$BookingDetailsStateImpl;
  const _BookingDetailsState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isUpdating;
  @override
  BookingData? get bookingData;
  @override
  BookingData? get afterUpdatedBookingData;
  @override
  bool get isUpdateNote;

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingDetailsStateImplCopyWith<_$BookingDetailsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
