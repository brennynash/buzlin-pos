// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_brand_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddBrandState {
  String get title => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isInitial => throw _privateConstructorUsedError;
  String? get imageFile => throw _privateConstructorUsedError;
  Brand? get brandData => throw _privateConstructorUsedError;

  /// Create a copy of AddBrandState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddBrandStateCopyWith<AddBrandState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddBrandStateCopyWith<$Res> {
  factory $AddBrandStateCopyWith(
          AddBrandState value, $Res Function(AddBrandState) then) =
      _$AddBrandStateCopyWithImpl<$Res, AddBrandState>;
  @useResult
  $Res call(
      {String title,
      bool active,
      bool isLoading,
      bool isInitial,
      String? imageFile,
      Brand? brandData});
}

/// @nodoc
class _$AddBrandStateCopyWithImpl<$Res, $Val extends AddBrandState>
    implements $AddBrandStateCopyWith<$Res> {
  _$AddBrandStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddBrandState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? active = null,
    Object? isLoading = null,
    Object? isInitial = null,
    Object? imageFile = freezed,
    Object? brandData = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isInitial: null == isInitial
          ? _value.isInitial
          : isInitial // ignore: cast_nullable_to_non_nullable
              as bool,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as String?,
      brandData: freezed == brandData
          ? _value.brandData
          : brandData // ignore: cast_nullable_to_non_nullable
              as Brand?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddBrandStateImplCopyWith<$Res>
    implements $AddBrandStateCopyWith<$Res> {
  factory _$$AddBrandStateImplCopyWith(
          _$AddBrandStateImpl value, $Res Function(_$AddBrandStateImpl) then) =
      __$$AddBrandStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      bool active,
      bool isLoading,
      bool isInitial,
      String? imageFile,
      Brand? brandData});
}

/// @nodoc
class __$$AddBrandStateImplCopyWithImpl<$Res>
    extends _$AddBrandStateCopyWithImpl<$Res, _$AddBrandStateImpl>
    implements _$$AddBrandStateImplCopyWith<$Res> {
  __$$AddBrandStateImplCopyWithImpl(
      _$AddBrandStateImpl _value, $Res Function(_$AddBrandStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddBrandState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? active = null,
    Object? isLoading = null,
    Object? isInitial = null,
    Object? imageFile = freezed,
    Object? brandData = freezed,
  }) {
    return _then(_$AddBrandStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isInitial: null == isInitial
          ? _value.isInitial
          : isInitial // ignore: cast_nullable_to_non_nullable
              as bool,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as String?,
      brandData: freezed == brandData
          ? _value.brandData
          : brandData // ignore: cast_nullable_to_non_nullable
              as Brand?,
    ));
  }
}

/// @nodoc

class _$AddBrandStateImpl extends _AddBrandState {
  const _$AddBrandStateImpl(
      {this.title = '',
      this.active = true,
      this.isLoading = false,
      this.isInitial = false,
      this.imageFile,
      this.brandData})
      : super._();

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isInitial;
  @override
  final String? imageFile;
  @override
  final Brand? brandData;

  @override
  String toString() {
    return 'AddBrandState(title: $title, active: $active, isLoading: $isLoading, isInitial: $isInitial, imageFile: $imageFile, brandData: $brandData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddBrandStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isInitial, isInitial) ||
                other.isInitial == isInitial) &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile) &&
            (identical(other.brandData, brandData) ||
                other.brandData == brandData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, active, isLoading, isInitial, imageFile, brandData);

  /// Create a copy of AddBrandState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddBrandStateImplCopyWith<_$AddBrandStateImpl> get copyWith =>
      __$$AddBrandStateImplCopyWithImpl<_$AddBrandStateImpl>(this, _$identity);
}

abstract class _AddBrandState extends AddBrandState {
  const factory _AddBrandState(
      {final String title,
      final bool active,
      final bool isLoading,
      final bool isInitial,
      final String? imageFile,
      final Brand? brandData}) = _$AddBrandStateImpl;
  const _AddBrandState._() : super._();

  @override
  String get title;
  @override
  bool get active;
  @override
  bool get isLoading;
  @override
  bool get isInitial;
  @override
  String? get imageFile;
  @override
  Brand? get brandData;

  /// Create a copy of AddBrandState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddBrandStateImplCopyWith<_$AddBrandStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
