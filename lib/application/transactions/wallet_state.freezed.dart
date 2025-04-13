// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletState {
  bool get isTransactionLoading => throw _privateConstructorUsedError;
  bool get isButtonLoading => throw _privateConstructorUsedError;
  bool get isSearchingLoading => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get selectPayment => throw _privateConstructorUsedError;
  List<TransactionModel> get transactions => throw _privateConstructorUsedError;
  List<PaymentData>? get list => throw _privateConstructorUsedError;
  List<UserData>? get listOfUser => throw _privateConstructorUsedError;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
          WalletState value, $Res Function(WalletState) then) =
      _$WalletStateCopyWithImpl<$Res, WalletState>;
  @useResult
  $Res call(
      {bool isTransactionLoading,
      bool isButtonLoading,
      bool isSearchingLoading,
      bool hasMore,
      int selectPayment,
      List<TransactionModel> transactions,
      List<PaymentData>? list,
      List<UserData>? listOfUser});
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTransactionLoading = null,
    Object? isButtonLoading = null,
    Object? isSearchingLoading = null,
    Object? hasMore = null,
    Object? selectPayment = null,
    Object? transactions = null,
    Object? list = freezed,
    Object? listOfUser = freezed,
  }) {
    return _then(_value.copyWith(
      isTransactionLoading: null == isTransactionLoading
          ? _value.isTransactionLoading
          : isTransactionLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonLoading: null == isButtonLoading
          ? _value.isButtonLoading
          : isButtonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSearchingLoading: null == isSearchingLoading
          ? _value.isSearchingLoading
          : isSearchingLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      selectPayment: null == selectPayment
          ? _value.selectPayment
          : selectPayment // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionModel>,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<PaymentData>?,
      listOfUser: freezed == listOfUser
          ? _value.listOfUser
          : listOfUser // ignore: cast_nullable_to_non_nullable
              as List<UserData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletStateImplCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$$WalletStateImplCopyWith(
          _$WalletStateImpl value, $Res Function(_$WalletStateImpl) then) =
      __$$WalletStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isTransactionLoading,
      bool isButtonLoading,
      bool isSearchingLoading,
      bool hasMore,
      int selectPayment,
      List<TransactionModel> transactions,
      List<PaymentData>? list,
      List<UserData>? listOfUser});
}

/// @nodoc
class __$$WalletStateImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletStateImpl>
    implements _$$WalletStateImplCopyWith<$Res> {
  __$$WalletStateImplCopyWithImpl(
      _$WalletStateImpl _value, $Res Function(_$WalletStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTransactionLoading = null,
    Object? isButtonLoading = null,
    Object? isSearchingLoading = null,
    Object? hasMore = null,
    Object? selectPayment = null,
    Object? transactions = null,
    Object? list = freezed,
    Object? listOfUser = freezed,
  }) {
    return _then(_$WalletStateImpl(
      isTransactionLoading: null == isTransactionLoading
          ? _value.isTransactionLoading
          : isTransactionLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isButtonLoading: null == isButtonLoading
          ? _value.isButtonLoading
          : isButtonLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSearchingLoading: null == isSearchingLoading
          ? _value.isSearchingLoading
          : isSearchingLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      selectPayment: null == selectPayment
          ? _value.selectPayment
          : selectPayment // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionModel>,
      list: freezed == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<PaymentData>?,
      listOfUser: freezed == listOfUser
          ? _value._listOfUser
          : listOfUser // ignore: cast_nullable_to_non_nullable
              as List<UserData>?,
    ));
  }
}

/// @nodoc

class _$WalletStateImpl implements _WalletState {
  const _$WalletStateImpl(
      {this.isTransactionLoading = false,
      this.isButtonLoading = false,
      this.isSearchingLoading = false,
      this.hasMore = true,
      this.selectPayment = 1,
      final List<TransactionModel> transactions = const [],
      final List<PaymentData>? list = const [],
      final List<UserData>? listOfUser = const []})
      : _transactions = transactions,
        _list = list,
        _listOfUser = listOfUser;

  @override
  @JsonKey()
  final bool isTransactionLoading;
  @override
  @JsonKey()
  final bool isButtonLoading;
  @override
  @JsonKey()
  final bool isSearchingLoading;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int selectPayment;
  final List<TransactionModel> _transactions;
  @override
  @JsonKey()
  List<TransactionModel> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  final List<PaymentData>? _list;
  @override
  @JsonKey()
  List<PaymentData>? get list {
    final value = _list;
    if (value == null) return null;
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserData>? _listOfUser;
  @override
  @JsonKey()
  List<UserData>? get listOfUser {
    final value = _listOfUser;
    if (value == null) return null;
    if (_listOfUser is EqualUnmodifiableListView) return _listOfUser;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WalletState(isTransactionLoading: $isTransactionLoading, isButtonLoading: $isButtonLoading, isSearchingLoading: $isSearchingLoading, hasMore: $hasMore, selectPayment: $selectPayment, transactions: $transactions, list: $list, listOfUser: $listOfUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStateImpl &&
            (identical(other.isTransactionLoading, isTransactionLoading) ||
                other.isTransactionLoading == isTransactionLoading) &&
            (identical(other.isButtonLoading, isButtonLoading) ||
                other.isButtonLoading == isButtonLoading) &&
            (identical(other.isSearchingLoading, isSearchingLoading) ||
                other.isSearchingLoading == isSearchingLoading) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.selectPayment, selectPayment) ||
                other.selectPayment == selectPayment) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality()
                .equals(other._listOfUser, _listOfUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isTransactionLoading,
      isButtonLoading,
      isSearchingLoading,
      hasMore,
      selectPayment,
      const DeepCollectionEquality().hash(_transactions),
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_listOfUser));

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      __$$WalletStateImplCopyWithImpl<_$WalletStateImpl>(this, _$identity);
}

abstract class _WalletState implements WalletState {
  const factory _WalletState(
      {final bool isTransactionLoading,
      final bool isButtonLoading,
      final bool isSearchingLoading,
      final bool hasMore,
      final int selectPayment,
      final List<TransactionModel> transactions,
      final List<PaymentData>? list,
      final List<UserData>? listOfUser}) = _$WalletStateImpl;

  @override
  bool get isTransactionLoading;
  @override
  bool get isButtonLoading;
  @override
  bool get isSearchingLoading;
  @override
  bool get hasMore;
  @override
  int get selectPayment;
  @override
  List<TransactionModel> get transactions;
  @override
  List<PaymentData>? get list;
  @override
  List<UserData>? get listOfUser;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
