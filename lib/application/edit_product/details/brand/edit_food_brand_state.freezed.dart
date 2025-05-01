// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_brand_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditFoodBrandState {
  List<Brand> get brands => throw _privateConstructorUsedError;
  Brand? get selectedBrand => throw _privateConstructorUsedError;
  TextEditingController? get brandController =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of EditFoodBrandState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditFoodBrandStateCopyWith<EditFoodBrandState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditFoodBrandStateCopyWith<$Res> {
  factory $EditFoodBrandStateCopyWith(
          EditFoodBrandState value, $Res Function(EditFoodBrandState) then) =
      _$EditFoodBrandStateCopyWithImpl<$Res, EditFoodBrandState>;
  @useResult
  $Res call(
      {List<Brand> brands,
      Brand? selectedBrand,
      TextEditingController? brandController,
      bool isLoading});
}

/// @nodoc
class _$EditFoodBrandStateCopyWithImpl<$Res, $Val extends EditFoodBrandState>
    implements $EditFoodBrandStateCopyWith<$Res> {
  _$EditFoodBrandStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditFoodBrandState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brands = null,
    Object? selectedBrand = freezed,
    Object? brandController = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      brands: null == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<Brand>,
      selectedBrand: freezed == selectedBrand
          ? _value.selectedBrand
          : selectedBrand // ignore: cast_nullable_to_non_nullable
              as Brand?,
      brandController: freezed == brandController
          ? _value.brandController
          : brandController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditFoodBrandStateImplCopyWith<$Res>
    implements $EditFoodBrandStateCopyWith<$Res> {
  factory _$$EditFoodBrandStateImplCopyWith(_$EditFoodBrandStateImpl value,
          $Res Function(_$EditFoodBrandStateImpl) then) =
      __$$EditFoodBrandStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Brand> brands,
      Brand? selectedBrand,
      TextEditingController? brandController,
      bool isLoading});
}

/// @nodoc
class __$$EditFoodBrandStateImplCopyWithImpl<$Res>
    extends _$EditFoodBrandStateCopyWithImpl<$Res, _$EditFoodBrandStateImpl>
    implements _$$EditFoodBrandStateImplCopyWith<$Res> {
  __$$EditFoodBrandStateImplCopyWithImpl(_$EditFoodBrandStateImpl _value,
      $Res Function(_$EditFoodBrandStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditFoodBrandState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brands = null,
    Object? selectedBrand = freezed,
    Object? brandController = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$EditFoodBrandStateImpl(
      brands: null == brands
          ? _value._brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<Brand>,
      selectedBrand: freezed == selectedBrand
          ? _value.selectedBrand
          : selectedBrand // ignore: cast_nullable_to_non_nullable
              as Brand?,
      brandController: freezed == brandController
          ? _value.brandController
          : brandController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EditFoodBrandStateImpl extends _EditFoodBrandState {
  const _$EditFoodBrandStateImpl(
      {final List<Brand> brands = const [],
      this.selectedBrand = null,
      this.brandController,
      this.isLoading = false})
      : _brands = brands,
        super._();

  final List<Brand> _brands;
  @override
  @JsonKey()
  List<Brand> get brands {
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brands);
  }

  @override
  @JsonKey()
  final Brand? selectedBrand;
  @override
  final TextEditingController? brandController;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'EditFoodBrandState(brands: $brands, selectedBrand: $selectedBrand, brandController: $brandController, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditFoodBrandStateImpl &&
            const DeepCollectionEquality().equals(other._brands, _brands) &&
            (identical(other.selectedBrand, selectedBrand) ||
                other.selectedBrand == selectedBrand) &&
            (identical(other.brandController, brandController) ||
                other.brandController == brandController) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_brands),
      selectedBrand,
      brandController,
      isLoading);

  /// Create a copy of EditFoodBrandState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditFoodBrandStateImplCopyWith<_$EditFoodBrandStateImpl> get copyWith =>
      __$$EditFoodBrandStateImplCopyWithImpl<_$EditFoodBrandStateImpl>(
          this, _$identity);
}

abstract class _EditFoodBrandState extends EditFoodBrandState {
  const factory _EditFoodBrandState(
      {final List<Brand> brands,
      final Brand? selectedBrand,
      final TextEditingController? brandController,
      final bool isLoading}) = _$EditFoodBrandStateImpl;
  const _EditFoodBrandState._() : super._();

  @override
  List<Brand> get brands;
  @override
  Brand? get selectedBrand;
  @override
  TextEditingController? get brandController;
  @override
  bool get isLoading;

  /// Create a copy of EditFoodBrandState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditFoodBrandStateImplCopyWith<_$EditFoodBrandStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
