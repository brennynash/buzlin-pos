// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ServicesState {
  bool get isServicesOpen => throw _privateConstructorUsedError;
  int get stateIndex => throw _privateConstructorUsedError;

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServicesStateCopyWith<ServicesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServicesStateCopyWith<$Res> {
  factory $ServicesStateCopyWith(
          ServicesState value, $Res Function(ServicesState) then) =
      _$ServicesStateCopyWithImpl<$Res, ServicesState>;
  @useResult
  $Res call({bool isServicesOpen, int stateIndex});
}

/// @nodoc
class _$ServicesStateCopyWithImpl<$Res, $Val extends ServicesState>
    implements $ServicesStateCopyWith<$Res> {
  _$ServicesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isServicesOpen = null,
    Object? stateIndex = null,
  }) {
    return _then(_value.copyWith(
      isServicesOpen: null == isServicesOpen
          ? _value.isServicesOpen
          : isServicesOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      stateIndex: null == stateIndex
          ? _value.stateIndex
          : stateIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServicesStateImplCopyWith<$Res>
    implements $ServicesStateCopyWith<$Res> {
  factory _$$ServicesStateImplCopyWith(
          _$ServicesStateImpl value, $Res Function(_$ServicesStateImpl) then) =
      __$$ServicesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isServicesOpen, int stateIndex});
}

/// @nodoc
class __$$ServicesStateImplCopyWithImpl<$Res>
    extends _$ServicesStateCopyWithImpl<$Res, _$ServicesStateImpl>
    implements _$$ServicesStateImplCopyWith<$Res> {
  __$$ServicesStateImplCopyWithImpl(
      _$ServicesStateImpl _value, $Res Function(_$ServicesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isServicesOpen = null,
    Object? stateIndex = null,
  }) {
    return _then(_$ServicesStateImpl(
      isServicesOpen: null == isServicesOpen
          ? _value.isServicesOpen
          : isServicesOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      stateIndex: null == stateIndex
          ? _value.stateIndex
          : stateIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ServicesStateImpl extends _ServicesState {
  const _$ServicesStateImpl({this.isServicesOpen = true, this.stateIndex = 0})
      : super._();

  @override
  @JsonKey()
  final bool isServicesOpen;
  @override
  @JsonKey()
  final int stateIndex;

  @override
  String toString() {
    return 'ServicesState(isServicesOpen: $isServicesOpen, stateIndex: $stateIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServicesStateImpl &&
            (identical(other.isServicesOpen, isServicesOpen) ||
                other.isServicesOpen == isServicesOpen) &&
            (identical(other.stateIndex, stateIndex) ||
                other.stateIndex == stateIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isServicesOpen, stateIndex);

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServicesStateImplCopyWith<_$ServicesStateImpl> get copyWith =>
      __$$ServicesStateImplCopyWithImpl<_$ServicesStateImpl>(this, _$identity);
}

abstract class _ServicesState extends ServicesState {
  const factory _ServicesState(
      {final bool isServicesOpen, final int stateIndex}) = _$ServicesStateImpl;
  const _ServicesState._() : super._();

  @override
  bool get isServicesOpen;
  @override
  int get stateIndex;

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServicesStateImplCopyWith<_$ServicesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
