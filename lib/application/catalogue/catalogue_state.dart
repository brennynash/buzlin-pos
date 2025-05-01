import 'package:freezed_annotation/freezed_annotation.dart';
part 'catalogue_state.freezed.dart';

@freezed
class CatalogueState with _$CatalogueState {
  const factory CatalogueState({
    @Default(true) bool isCatalogueOpen,
    @Default(0) int stateIndex,
  }) = _CatalogueState;

  const CatalogueState._();
}