// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'membership_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MembershipState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isPaymentLoading => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get selectPayment => throw _privateConstructorUsedError;
  int get selectSubscribe => throw _privateConstructorUsedError;
  List<MembershipData> get list => throw _privateConstructorUsedError;
  List<PaymentData>? get payments => throw _privateConstructorUsedError;

  /// Create a copy of MembershipState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MembershipStateCopyWith<MembershipState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MembershipStateCopyWith<$Res> {
  factory $MembershipStateCopyWith(
          MembershipState value, $Res Function(MembershipState) then) =
      _$MembershipStateCopyWithImpl<$Res, MembershipState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isPaymentLoading,
      bool hasMore,
      int selectPayment,
      int selectSubscribe,
      List<MembershipData> list,
      List<PaymentData>? payments});
}

/// @nodoc
class _$MembershipStateCopyWithImpl<$Res, $Val extends MembershipState>
    implements $MembershipStateCopyWith<$Res> {
  _$MembershipStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MembershipState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isPaymentLoading = null,
    Object? hasMore = null,
    Object? selectPayment = null,
    Object? selectSubscribe = null,
    Object? list = null,
    Object? payments = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaymentLoading: null == isPaymentLoading
          ? _value.isPaymentLoading
          : isPaymentLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      selectPayment: null == selectPayment
          ? _value.selectPayment
          : selectPayment // ignore: cast_nullable_to_non_nullable
              as int,
      selectSubscribe: null == selectSubscribe
          ? _value.selectSubscribe
          : selectSubscribe // ignore: cast_nullable_to_non_nullable
              as int,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<MembershipData>,
      payments: freezed == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MembershipStateImplCopyWith<$Res>
    implements $MembershipStateCopyWith<$Res> {
  factory _$$MembershipStateImplCopyWith(_$MembershipStateImpl value,
          $Res Function(_$MembershipStateImpl) then) =
      __$$MembershipStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isPaymentLoading,
      bool hasMore,
      int selectPayment,
      int selectSubscribe,
      List<MembershipData> list,
      List<PaymentData>? payments});
}

/// @nodoc
class __$$MembershipStateImplCopyWithImpl<$Res>
    extends _$MembershipStateCopyWithImpl<$Res, _$MembershipStateImpl>
    implements _$$MembershipStateImplCopyWith<$Res> {
  __$$MembershipStateImplCopyWithImpl(
      _$MembershipStateImpl _value, $Res Function(_$MembershipStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MembershipState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isPaymentLoading = null,
    Object? hasMore = null,
    Object? selectPayment = null,
    Object? selectSubscribe = null,
    Object? list = null,
    Object? payments = freezed,
  }) {
    return _then(_$MembershipStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaymentLoading: null == isPaymentLoading
          ? _value.isPaymentLoading
          : isPaymentLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      selectPayment: null == selectPayment
          ? _value.selectPayment
          : selectPayment // ignore: cast_nullable_to_non_nullable
              as int,
      selectSubscribe: null == selectSubscribe
          ? _value.selectSubscribe
          : selectSubscribe // ignore: cast_nullable_to_non_nullable
              as int,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<MembershipData>,
      payments: freezed == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentData>?,
    ));
  }
}

/// @nodoc

class _$MembershipStateImpl extends _MembershipState {
  const _$MembershipStateImpl(
      {this.isLoading = false,
      this.isPaymentLoading = false,
      this.hasMore = true,
      this.selectPayment = 1,
      this.selectSubscribe = 0,
      final List<MembershipData> list = const [],
      final List<PaymentData>? payments = const []})
      : _list = list,
        _payments = payments,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isPaymentLoading;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int selectPayment;
  @override
  @JsonKey()
  final int selectSubscribe;
  final List<MembershipData> _list;
  @override
  @JsonKey()
  List<MembershipData> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  final List<PaymentData>? _payments;
  @override
  @JsonKey()
  List<PaymentData>? get payments {
    final value = _payments;
    if (value == null) return null;
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MembershipState(isLoading: $isLoading, isPaymentLoading: $isPaymentLoading, hasMore: $hasMore, selectPayment: $selectPayment, selectSubscribe: $selectSubscribe, list: $list, payments: $payments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MembershipStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isPaymentLoading, isPaymentLoading) ||
                other.isPaymentLoading == isPaymentLoading) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.selectPayment, selectPayment) ||
                other.selectPayment == selectPayment) &&
            (identical(other.selectSubscribe, selectSubscribe) ||
                other.selectSubscribe == selectSubscribe) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isPaymentLoading,
      hasMore,
      selectPayment,
      selectSubscribe,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_payments));

  /// Create a copy of MembershipState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MembershipStateImplCopyWith<_$MembershipStateImpl> get copyWith =>
      __$$MembershipStateImplCopyWithImpl<_$MembershipStateImpl>(
          this, _$identity);
}

abstract class _MembershipState extends MembershipState {
  const factory _MembershipState(
      {final bool isLoading,
      final bool isPaymentLoading,
      final bool hasMore,
      final int selectPayment,
      final int selectSubscribe,
      final List<MembershipData> list,
      final List<PaymentData>? payments}) = _$MembershipStateImpl;
  const _MembershipState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isPaymentLoading;
  @override
  bool get hasMore;
  @override
  int get selectPayment;
  @override
  int get selectSubscribe;
  @override
  List<MembershipData> get list;
  @override
  List<PaymentData>? get payments;

  /// Create a copy of MembershipState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MembershipStateImplCopyWith<_$MembershipStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
