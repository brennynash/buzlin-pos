// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_stocks_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditFoodStocksState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  bool get isFetchingGroups => throw _privateConstructorUsedError;
  ProductData? get product => throw _privateConstructorUsedError;
  List<int> get deleteStocks => throw _privateConstructorUsedError;
  List<Group> get groups => throw _privateConstructorUsedError;
  List<Stocks> get stocks => throw _privateConstructorUsedError;
  List<Extras> get activeGroupExtras => throw _privateConstructorUsedError;
  List<TextEditingController> get quantityControllers =>
      throw _privateConstructorUsedError;
  List<TextEditingController> get priceControllers =>
      throw _privateConstructorUsedError;
  List<TextEditingController> get skuControllers =>
      throw _privateConstructorUsedError;
  Map<String, List<Extras?>> get selectGroups =>
      throw _privateConstructorUsedError;

  /// Create a copy of EditFoodStocksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditFoodStocksStateCopyWith<EditFoodStocksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditFoodStocksStateCopyWith<$Res> {
  factory $EditFoodStocksStateCopyWith(
          EditFoodStocksState value, $Res Function(EditFoodStocksState) then) =
      _$EditFoodStocksStateCopyWithImpl<$Res, EditFoodStocksState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isSaving,
      bool isFetchingGroups,
      ProductData? product,
      List<int> deleteStocks,
      List<Group> groups,
      List<Stocks> stocks,
      List<Extras> activeGroupExtras,
      List<TextEditingController> quantityControllers,
      List<TextEditingController> priceControllers,
      List<TextEditingController> skuControllers,
      Map<String, List<Extras?>> selectGroups});
}

/// @nodoc
class _$EditFoodStocksStateCopyWithImpl<$Res, $Val extends EditFoodStocksState>
    implements $EditFoodStocksStateCopyWith<$Res> {
  _$EditFoodStocksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditFoodStocksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isFetchingGroups = null,
    Object? product = freezed,
    Object? deleteStocks = null,
    Object? groups = null,
    Object? stocks = null,
    Object? activeGroupExtras = null,
    Object? quantityControllers = null,
    Object? priceControllers = null,
    Object? skuControllers = null,
    Object? selectGroups = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingGroups: null == isFetchingGroups
          ? _value.isFetchingGroups
          : isFetchingGroups // ignore: cast_nullable_to_non_nullable
              as bool,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      deleteStocks: null == deleteStocks
          ? _value.deleteStocks
          : deleteStocks // ignore: cast_nullable_to_non_nullable
              as List<int>,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<Group>,
      stocks: null == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stocks>,
      activeGroupExtras: null == activeGroupExtras
          ? _value.activeGroupExtras
          : activeGroupExtras // ignore: cast_nullable_to_non_nullable
              as List<Extras>,
      quantityControllers: null == quantityControllers
          ? _value.quantityControllers
          : quantityControllers // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      priceControllers: null == priceControllers
          ? _value.priceControllers
          : priceControllers // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      skuControllers: null == skuControllers
          ? _value.skuControllers
          : skuControllers // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      selectGroups: null == selectGroups
          ? _value.selectGroups
          : selectGroups // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Extras?>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditFoodStocksStateImplCopyWith<$Res>
    implements $EditFoodStocksStateCopyWith<$Res> {
  factory _$$EditFoodStocksStateImplCopyWith(_$EditFoodStocksStateImpl value,
          $Res Function(_$EditFoodStocksStateImpl) then) =
      __$$EditFoodStocksStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isSaving,
      bool isFetchingGroups,
      ProductData? product,
      List<int> deleteStocks,
      List<Group> groups,
      List<Stocks> stocks,
      List<Extras> activeGroupExtras,
      List<TextEditingController> quantityControllers,
      List<TextEditingController> priceControllers,
      List<TextEditingController> skuControllers,
      Map<String, List<Extras?>> selectGroups});
}

/// @nodoc
class __$$EditFoodStocksStateImplCopyWithImpl<$Res>
    extends _$EditFoodStocksStateCopyWithImpl<$Res, _$EditFoodStocksStateImpl>
    implements _$$EditFoodStocksStateImplCopyWith<$Res> {
  __$$EditFoodStocksStateImplCopyWithImpl(_$EditFoodStocksStateImpl _value,
      $Res Function(_$EditFoodStocksStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditFoodStocksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isFetchingGroups = null,
    Object? product = freezed,
    Object? deleteStocks = null,
    Object? groups = null,
    Object? stocks = null,
    Object? activeGroupExtras = null,
    Object? quantityControllers = null,
    Object? priceControllers = null,
    Object? skuControllers = null,
    Object? selectGroups = null,
  }) {
    return _then(_$EditFoodStocksStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingGroups: null == isFetchingGroups
          ? _value.isFetchingGroups
          : isFetchingGroups // ignore: cast_nullable_to_non_nullable
              as bool,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      deleteStocks: null == deleteStocks
          ? _value._deleteStocks
          : deleteStocks // ignore: cast_nullable_to_non_nullable
              as List<int>,
      groups: null == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<Group>,
      stocks: null == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stocks>,
      activeGroupExtras: null == activeGroupExtras
          ? _value._activeGroupExtras
          : activeGroupExtras // ignore: cast_nullable_to_non_nullable
              as List<Extras>,
      quantityControllers: null == quantityControllers
          ? _value._quantityControllers
          : quantityControllers // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      priceControllers: null == priceControllers
          ? _value._priceControllers
          : priceControllers // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      skuControllers: null == skuControllers
          ? _value._skuControllers
          : skuControllers // ignore: cast_nullable_to_non_nullable
              as List<TextEditingController>,
      selectGroups: null == selectGroups
          ? _value._selectGroups
          : selectGroups // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Extras?>>,
    ));
  }
}

/// @nodoc

class _$EditFoodStocksStateImpl extends _EditFoodStocksState {
  const _$EditFoodStocksStateImpl(
      {this.isLoading = false,
      this.isSaving = false,
      this.isFetchingGroups = false,
      this.product = null,
      final List<int> deleteStocks = const [],
      final List<Group> groups = const [],
      final List<Stocks> stocks = const [],
      final List<Extras> activeGroupExtras = const [],
      final List<TextEditingController> quantityControllers = const [],
      final List<TextEditingController> priceControllers = const [],
      final List<TextEditingController> skuControllers = const [],
      final Map<String, List<Extras?>> selectGroups = const {}})
      : _deleteStocks = deleteStocks,
        _groups = groups,
        _stocks = stocks,
        _activeGroupExtras = activeGroupExtras,
        _quantityControllers = quantityControllers,
        _priceControllers = priceControllers,
        _skuControllers = skuControllers,
        _selectGroups = selectGroups,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isFetchingGroups;
  @override
  @JsonKey()
  final ProductData? product;
  final List<int> _deleteStocks;
  @override
  @JsonKey()
  List<int> get deleteStocks {
    if (_deleteStocks is EqualUnmodifiableListView) return _deleteStocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deleteStocks);
  }

  final List<Group> _groups;
  @override
  @JsonKey()
  List<Group> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  final List<Stocks> _stocks;
  @override
  @JsonKey()
  List<Stocks> get stocks {
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stocks);
  }

  final List<Extras> _activeGroupExtras;
  @override
  @JsonKey()
  List<Extras> get activeGroupExtras {
    if (_activeGroupExtras is EqualUnmodifiableListView)
      return _activeGroupExtras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeGroupExtras);
  }

  final List<TextEditingController> _quantityControllers;
  @override
  @JsonKey()
  List<TextEditingController> get quantityControllers {
    if (_quantityControllers is EqualUnmodifiableListView)
      return _quantityControllers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quantityControllers);
  }

  final List<TextEditingController> _priceControllers;
  @override
  @JsonKey()
  List<TextEditingController> get priceControllers {
    if (_priceControllers is EqualUnmodifiableListView)
      return _priceControllers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priceControllers);
  }

  final List<TextEditingController> _skuControllers;
  @override
  @JsonKey()
  List<TextEditingController> get skuControllers {
    if (_skuControllers is EqualUnmodifiableListView) return _skuControllers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skuControllers);
  }

  final Map<String, List<Extras?>> _selectGroups;
  @override
  @JsonKey()
  Map<String, List<Extras?>> get selectGroups {
    if (_selectGroups is EqualUnmodifiableMapView) return _selectGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectGroups);
  }

  @override
  String toString() {
    return 'EditFoodStocksState(isLoading: $isLoading, isSaving: $isSaving, isFetchingGroups: $isFetchingGroups, product: $product, deleteStocks: $deleteStocks, groups: $groups, stocks: $stocks, activeGroupExtras: $activeGroupExtras, quantityControllers: $quantityControllers, priceControllers: $priceControllers, skuControllers: $skuControllers, selectGroups: $selectGroups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditFoodStocksStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isFetchingGroups, isFetchingGroups) ||
                other.isFetchingGroups == isFetchingGroups) &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality()
                .equals(other._deleteStocks, _deleteStocks) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            const DeepCollectionEquality().equals(other._stocks, _stocks) &&
            const DeepCollectionEquality()
                .equals(other._activeGroupExtras, _activeGroupExtras) &&
            const DeepCollectionEquality()
                .equals(other._quantityControllers, _quantityControllers) &&
            const DeepCollectionEquality()
                .equals(other._priceControllers, _priceControllers) &&
            const DeepCollectionEquality()
                .equals(other._skuControllers, _skuControllers) &&
            const DeepCollectionEquality()
                .equals(other._selectGroups, _selectGroups));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isSaving,
      isFetchingGroups,
      product,
      const DeepCollectionEquality().hash(_deleteStocks),
      const DeepCollectionEquality().hash(_groups),
      const DeepCollectionEquality().hash(_stocks),
      const DeepCollectionEquality().hash(_activeGroupExtras),
      const DeepCollectionEquality().hash(_quantityControllers),
      const DeepCollectionEquality().hash(_priceControllers),
      const DeepCollectionEquality().hash(_skuControllers),
      const DeepCollectionEquality().hash(_selectGroups));

  /// Create a copy of EditFoodStocksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditFoodStocksStateImplCopyWith<_$EditFoodStocksStateImpl> get copyWith =>
      __$$EditFoodStocksStateImplCopyWithImpl<_$EditFoodStocksStateImpl>(
          this, _$identity);
}

abstract class _EditFoodStocksState extends EditFoodStocksState {
  const factory _EditFoodStocksState(
          {final bool isLoading,
          final bool isSaving,
          final bool isFetchingGroups,
          final ProductData? product,
          final List<int> deleteStocks,
          final List<Group> groups,
          final List<Stocks> stocks,
          final List<Extras> activeGroupExtras,
          final List<TextEditingController> quantityControllers,
          final List<TextEditingController> priceControllers,
          final List<TextEditingController> skuControllers,
          final Map<String, List<Extras?>> selectGroups}) =
      _$EditFoodStocksStateImpl;
  const _EditFoodStocksState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  bool get isFetchingGroups;
  @override
  ProductData? get product;
  @override
  List<int> get deleteStocks;
  @override
  List<Group> get groups;
  @override
  List<Stocks> get stocks;
  @override
  List<Extras> get activeGroupExtras;
  @override
  List<TextEditingController> get quantityControllers;
  @override
  List<TextEditingController> get priceControllers;
  @override
  List<TextEditingController> get skuControllers;
  @override
  Map<String, List<Extras?>> get selectGroups;

  /// Create a copy of EditFoodStocksState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditFoodStocksStateImplCopyWith<_$EditFoodStocksStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
