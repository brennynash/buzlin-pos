// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accepted_masters_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AcceptedMastersState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<UserData> get users => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String get acceptedMastersQuery => throw _privateConstructorUsedError;
  List<DropDownItemData> get dropdownUsers =>
      throw _privateConstructorUsedError;

  /// Create a copy of AcceptedMastersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcceptedMastersStateCopyWith<AcceptedMastersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptedMastersStateCopyWith<$Res> {
  factory $AcceptedMastersStateCopyWith(AcceptedMastersState value,
          $Res Function(AcceptedMastersState) then) =
      _$AcceptedMastersStateCopyWithImpl<$Res, AcceptedMastersState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<UserData> users,
      int totalCount,
      bool hasMore,
      String acceptedMastersQuery,
      List<DropDownItemData> dropdownUsers});
}

/// @nodoc
class _$AcceptedMastersStateCopyWithImpl<$Res,
        $Val extends AcceptedMastersState>
    implements $AcceptedMastersStateCopyWith<$Res> {
  _$AcceptedMastersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcceptedMastersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? users = null,
    Object? totalCount = null,
    Object? hasMore = null,
    Object? acceptedMastersQuery = null,
    Object? dropdownUsers = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserData>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      acceptedMastersQuery: null == acceptedMastersQuery
          ? _value.acceptedMastersQuery
          : acceptedMastersQuery // ignore: cast_nullable_to_non_nullable
              as String,
      dropdownUsers: null == dropdownUsers
          ? _value.dropdownUsers
          : dropdownUsers // ignore: cast_nullable_to_non_nullable
              as List<DropDownItemData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AcceptedMastersStateImplCopyWith<$Res>
    implements $AcceptedMastersStateCopyWith<$Res> {
  factory _$$AcceptedMastersStateImplCopyWith(_$AcceptedMastersStateImpl value,
          $Res Function(_$AcceptedMastersStateImpl) then) =
      __$$AcceptedMastersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<UserData> users,
      int totalCount,
      bool hasMore,
      String acceptedMastersQuery,
      List<DropDownItemData> dropdownUsers});
}

/// @nodoc
class __$$AcceptedMastersStateImplCopyWithImpl<$Res>
    extends _$AcceptedMastersStateCopyWithImpl<$Res, _$AcceptedMastersStateImpl>
    implements _$$AcceptedMastersStateImplCopyWith<$Res> {
  __$$AcceptedMastersStateImplCopyWithImpl(_$AcceptedMastersStateImpl _value,
      $Res Function(_$AcceptedMastersStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AcceptedMastersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? users = null,
    Object? totalCount = null,
    Object? hasMore = null,
    Object? acceptedMastersQuery = null,
    Object? dropdownUsers = null,
  }) {
    return _then(_$AcceptedMastersStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserData>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      acceptedMastersQuery: null == acceptedMastersQuery
          ? _value.acceptedMastersQuery
          : acceptedMastersQuery // ignore: cast_nullable_to_non_nullable
              as String,
      dropdownUsers: null == dropdownUsers
          ? _value._dropdownUsers
          : dropdownUsers // ignore: cast_nullable_to_non_nullable
              as List<DropDownItemData>,
    ));
  }
}

/// @nodoc

class _$AcceptedMastersStateImpl extends _AcceptedMastersState {
  const _$AcceptedMastersStateImpl(
      {this.isLoading = false,
      final List<UserData> users = const [],
      this.totalCount = 0,
      this.hasMore = true,
      this.acceptedMastersQuery = '',
      final List<DropDownItemData> dropdownUsers = const []})
      : _users = users,
        _dropdownUsers = dropdownUsers,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<UserData> _users;
  @override
  @JsonKey()
  List<UserData> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final String acceptedMastersQuery;
  final List<DropDownItemData> _dropdownUsers;
  @override
  @JsonKey()
  List<DropDownItemData> get dropdownUsers {
    if (_dropdownUsers is EqualUnmodifiableListView) return _dropdownUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dropdownUsers);
  }

  @override
  String toString() {
    return 'AcceptedMastersState(isLoading: $isLoading, users: $users, totalCount: $totalCount, hasMore: $hasMore, acceptedMastersQuery: $acceptedMastersQuery, dropdownUsers: $dropdownUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptedMastersStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.acceptedMastersQuery, acceptedMastersQuery) ||
                other.acceptedMastersQuery == acceptedMastersQuery) &&
            const DeepCollectionEquality()
                .equals(other._dropdownUsers, _dropdownUsers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_users),
      totalCount,
      hasMore,
      acceptedMastersQuery,
      const DeepCollectionEquality().hash(_dropdownUsers));

  /// Create a copy of AcceptedMastersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptedMastersStateImplCopyWith<_$AcceptedMastersStateImpl>
      get copyWith =>
          __$$AcceptedMastersStateImplCopyWithImpl<_$AcceptedMastersStateImpl>(
              this, _$identity);
}

abstract class _AcceptedMastersState extends AcceptedMastersState {
  const factory _AcceptedMastersState(
      {final bool isLoading,
      final List<UserData> users,
      final int totalCount,
      final bool hasMore,
      final String acceptedMastersQuery,
      final List<DropDownItemData> dropdownUsers}) = _$AcceptedMastersStateImpl;
  const _AcceptedMastersState._() : super._();

  @override
  bool get isLoading;
  @override
  List<UserData> get users;
  @override
  int get totalCount;
  @override
  bool get hasMore;
  @override
  String get acceptedMastersQuery;
  @override
  List<DropDownItemData> get dropdownUsers;

  /// Create a copy of AcceptedMastersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptedMastersStateImplCopyWith<_$AcceptedMastersStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
