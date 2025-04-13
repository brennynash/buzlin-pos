// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalogue_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CatalogueState {
  bool get isCatalogueOpen => throw _privateConstructorUsedError;
  int get stateIndex => throw _privateConstructorUsedError;

  /// Create a copy of CatalogueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogueStateCopyWith<CatalogueState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogueStateCopyWith<$Res> {
  factory $CatalogueStateCopyWith(
          CatalogueState value, $Res Function(CatalogueState) then) =
      _$CatalogueStateCopyWithImpl<$Res, CatalogueState>;
  @useResult
  $Res call({bool isCatalogueOpen, int stateIndex});
}

/// @nodoc
class _$CatalogueStateCopyWithImpl<$Res, $Val extends CatalogueState>
    implements $CatalogueStateCopyWith<$Res> {
  _$CatalogueStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCatalogueOpen = null,
    Object? stateIndex = null,
  }) {
    return _then(_value.copyWith(
      isCatalogueOpen: null == isCatalogueOpen
          ? _value.isCatalogueOpen
          : isCatalogueOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      stateIndex: null == stateIndex
          ? _value.stateIndex
          : stateIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CatalogueStateImplCopyWith<$Res>
    implements $CatalogueStateCopyWith<$Res> {
  factory _$$CatalogueStateImplCopyWith(_$CatalogueStateImpl value,
          $Res Function(_$CatalogueStateImpl) then) =
      __$$CatalogueStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isCatalogueOpen, int stateIndex});
}

/// @nodoc
class __$$CatalogueStateImplCopyWithImpl<$Res>
    extends _$CatalogueStateCopyWithImpl<$Res, _$CatalogueStateImpl>
    implements _$$CatalogueStateImplCopyWith<$Res> {
  __$$CatalogueStateImplCopyWithImpl(
      _$CatalogueStateImpl _value, $Res Function(_$CatalogueStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CatalogueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCatalogueOpen = null,
    Object? stateIndex = null,
  }) {
    return _then(_$CatalogueStateImpl(
      isCatalogueOpen: null == isCatalogueOpen
          ? _value.isCatalogueOpen
          : isCatalogueOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      stateIndex: null == stateIndex
          ? _value.stateIndex
          : stateIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CatalogueStateImpl extends _CatalogueState {
  const _$CatalogueStateImpl({this.isCatalogueOpen = true, this.stateIndex = 0})
      : super._();

  @override
  @JsonKey()
  final bool isCatalogueOpen;
  @override
  @JsonKey()
  final int stateIndex;

  @override
  String toString() {
    return 'CatalogueState(isCatalogueOpen: $isCatalogueOpen, stateIndex: $stateIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogueStateImpl &&
            (identical(other.isCatalogueOpen, isCatalogueOpen) ||
                other.isCatalogueOpen == isCatalogueOpen) &&
            (identical(other.stateIndex, stateIndex) ||
                other.stateIndex == stateIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCatalogueOpen, stateIndex);

  /// Create a copy of CatalogueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogueStateImplCopyWith<_$CatalogueStateImpl> get copyWith =>
      __$$CatalogueStateImplCopyWithImpl<_$CatalogueStateImpl>(
          this, _$identity);
}

abstract class _CatalogueState extends CatalogueState {
  const factory _CatalogueState(
      {final bool isCatalogueOpen,
      final int stateIndex}) = _$CatalogueStateImpl;
  const _CatalogueState._() : super._();

  @override
  bool get isCatalogueOpen;
  @override
  int get stateIndex;

  /// Create a copy of CatalogueState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogueStateImplCopyWith<_$CatalogueStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
