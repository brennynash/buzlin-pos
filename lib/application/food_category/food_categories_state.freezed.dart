// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FoodCategoriesState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<CategoryData> get categories => throw _privateConstructorUsedError;
  bool get isAllSelect => throw _privateConstructorUsedError;
  List<dynamic> get selectCategories => throw _privateConstructorUsedError;
  List<int> get selectParents => throw _privateConstructorUsedError;
  List<int> get selectSubs => throw _privateConstructorUsedError;

  /// Create a copy of FoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodCategoriesStateCopyWith<FoodCategoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodCategoriesStateCopyWith<$Res> {
  factory $FoodCategoriesStateCopyWith(
          FoodCategoriesState value, $Res Function(FoodCategoriesState) then) =
      _$FoodCategoriesStateCopyWithImpl<$Res, FoodCategoriesState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<CategoryData> categories,
      bool isAllSelect,
      List<dynamic> selectCategories,
      List<int> selectParents,
      List<int> selectSubs});
}

/// @nodoc
class _$FoodCategoriesStateCopyWithImpl<$Res, $Val extends FoodCategoriesState>
    implements $FoodCategoriesStateCopyWith<$Res> {
  _$FoodCategoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? categories = null,
    Object? isAllSelect = null,
    Object? selectCategories = null,
    Object? selectParents = null,
    Object? selectSubs = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      isAllSelect: null == isAllSelect
          ? _value.isAllSelect
          : isAllSelect // ignore: cast_nullable_to_non_nullable
              as bool,
      selectCategories: null == selectCategories
          ? _value.selectCategories
          : selectCategories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      selectParents: null == selectParents
          ? _value.selectParents
          : selectParents // ignore: cast_nullable_to_non_nullable
              as List<int>,
      selectSubs: null == selectSubs
          ? _value.selectSubs
          : selectSubs // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodCategoriesStateImplCopyWith<$Res>
    implements $FoodCategoriesStateCopyWith<$Res> {
  factory _$$FoodCategoriesStateImplCopyWith(_$FoodCategoriesStateImpl value,
          $Res Function(_$FoodCategoriesStateImpl) then) =
      __$$FoodCategoriesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<CategoryData> categories,
      bool isAllSelect,
      List<dynamic> selectCategories,
      List<int> selectParents,
      List<int> selectSubs});
}

/// @nodoc
class __$$FoodCategoriesStateImplCopyWithImpl<$Res>
    extends _$FoodCategoriesStateCopyWithImpl<$Res, _$FoodCategoriesStateImpl>
    implements _$$FoodCategoriesStateImplCopyWith<$Res> {
  __$$FoodCategoriesStateImplCopyWithImpl(_$FoodCategoriesStateImpl _value,
      $Res Function(_$FoodCategoriesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? categories = null,
    Object? isAllSelect = null,
    Object? selectCategories = null,
    Object? selectParents = null,
    Object? selectSubs = null,
  }) {
    return _then(_$FoodCategoriesStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryData>,
      isAllSelect: null == isAllSelect
          ? _value.isAllSelect
          : isAllSelect // ignore: cast_nullable_to_non_nullable
              as bool,
      selectCategories: null == selectCategories
          ? _value._selectCategories
          : selectCategories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      selectParents: null == selectParents
          ? _value._selectParents
          : selectParents // ignore: cast_nullable_to_non_nullable
              as List<int>,
      selectSubs: null == selectSubs
          ? _value._selectSubs
          : selectSubs // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$FoodCategoriesStateImpl extends _FoodCategoriesState {
  const _$FoodCategoriesStateImpl(
      {this.isLoading = false,
      final List<CategoryData> categories = const [],
      this.isAllSelect = false,
      final List<dynamic> selectCategories = const [],
      final List<int> selectParents = const [],
      final List<int> selectSubs = const []})
      : _categories = categories,
        _selectCategories = selectCategories,
        _selectParents = selectParents,
        _selectSubs = selectSubs,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<CategoryData> _categories;
  @override
  @JsonKey()
  List<CategoryData> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final bool isAllSelect;
  final List<dynamic> _selectCategories;
  @override
  @JsonKey()
  List<dynamic> get selectCategories {
    if (_selectCategories is EqualUnmodifiableListView)
      return _selectCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectCategories);
  }

  final List<int> _selectParents;
  @override
  @JsonKey()
  List<int> get selectParents {
    if (_selectParents is EqualUnmodifiableListView) return _selectParents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectParents);
  }

  final List<int> _selectSubs;
  @override
  @JsonKey()
  List<int> get selectSubs {
    if (_selectSubs is EqualUnmodifiableListView) return _selectSubs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectSubs);
  }

  @override
  String toString() {
    return 'FoodCategoriesState(isLoading: $isLoading, categories: $categories, isAllSelect: $isAllSelect, selectCategories: $selectCategories, selectParents: $selectParents, selectSubs: $selectSubs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodCategoriesStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.isAllSelect, isAllSelect) ||
                other.isAllSelect == isAllSelect) &&
            const DeepCollectionEquality()
                .equals(other._selectCategories, _selectCategories) &&
            const DeepCollectionEquality()
                .equals(other._selectParents, _selectParents) &&
            const DeepCollectionEquality()
                .equals(other._selectSubs, _selectSubs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_categories),
      isAllSelect,
      const DeepCollectionEquality().hash(_selectCategories),
      const DeepCollectionEquality().hash(_selectParents),
      const DeepCollectionEquality().hash(_selectSubs));

  /// Create a copy of FoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodCategoriesStateImplCopyWith<_$FoodCategoriesStateImpl> get copyWith =>
      __$$FoodCategoriesStateImplCopyWithImpl<_$FoodCategoriesStateImpl>(
          this, _$identity);
}

abstract class _FoodCategoriesState extends FoodCategoriesState {
  const factory _FoodCategoriesState(
      {final bool isLoading,
      final List<CategoryData> categories,
      final bool isAllSelect,
      final List<dynamic> selectCategories,
      final List<int> selectParents,
      final List<int> selectSubs}) = _$FoodCategoriesStateImpl;
  const _FoodCategoriesState._() : super._();

  @override
  bool get isLoading;
  @override
  List<CategoryData> get categories;
  @override
  bool get isAllSelect;
  @override
  List<dynamic> get selectCategories;
  @override
  List<int> get selectParents;
  @override
  List<int> get selectSubs;

  /// Create a copy of FoodCategoriesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodCategoriesStateImplCopyWith<_$FoodCategoriesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
