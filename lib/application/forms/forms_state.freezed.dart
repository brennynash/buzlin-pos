// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forms_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FormOptionState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<FormOptionsData> get list => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;

  /// Create a copy of FormOptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormOptionStateCopyWith<FormOptionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormOptionStateCopyWith<$Res> {
  factory $FormOptionStateCopyWith(
          FormOptionState value, $Res Function(FormOptionState) then) =
      _$FormOptionStateCopyWithImpl<$Res, FormOptionState>;
  @useResult
  $Res call({bool isLoading, List<FormOptionsData> list, bool hasMore});
}

/// @nodoc
class _$FormOptionStateCopyWithImpl<$Res, $Val extends FormOptionState>
    implements $FormOptionStateCopyWith<$Res> {
  _$FormOptionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormOptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? list = null,
    Object? hasMore = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<FormOptionsData>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FormOptionStateImplCopyWith<$Res>
    implements $FormOptionStateCopyWith<$Res> {
  factory _$$FormOptionStateImplCopyWith(_$FormOptionStateImpl value,
          $Res Function(_$FormOptionStateImpl) then) =
      __$$FormOptionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<FormOptionsData> list, bool hasMore});
}

/// @nodoc
class __$$FormOptionStateImplCopyWithImpl<$Res>
    extends _$FormOptionStateCopyWithImpl<$Res, _$FormOptionStateImpl>
    implements _$$FormOptionStateImplCopyWith<$Res> {
  __$$FormOptionStateImplCopyWithImpl(
      _$FormOptionStateImpl _value, $Res Function(_$FormOptionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FormOptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? list = null,
    Object? hasMore = null,
  }) {
    return _then(_$FormOptionStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<FormOptionsData>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FormOptionStateImpl extends _FormOptionState {
  const _$FormOptionStateImpl(
      {this.isLoading = false,
      final List<FormOptionsData> list = const [],
      this.hasMore = true})
      : _list = list,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<FormOptionsData> _list;
  @override
  @JsonKey()
  List<FormOptionsData> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final bool hasMore;

  @override
  String toString() {
    return 'FormOptionState(isLoading: $isLoading, list: $list, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormOptionStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_list), hasMore);

  /// Create a copy of FormOptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormOptionStateImplCopyWith<_$FormOptionStateImpl> get copyWith =>
      __$$FormOptionStateImplCopyWithImpl<_$FormOptionStateImpl>(
          this, _$identity);
}

abstract class _FormOptionState extends FormOptionState {
  const factory _FormOptionState(
      {final bool isLoading,
      final List<FormOptionsData> list,
      final bool hasMore}) = _$FormOptionStateImpl;
  const _FormOptionState._() : super._();

  @override
  bool get isLoading;
  @override
  List<FormOptionsData> get list;
  @override
  bool get hasMore;

  /// Create a copy of FormOptionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormOptionStateImplCopyWith<_$FormOptionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
