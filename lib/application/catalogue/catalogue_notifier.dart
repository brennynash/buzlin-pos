import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'catalogue_state.dart';

class CatalogueNotifier extends StateNotifier<CatalogueState> {
  CatalogueNotifier() : super(const CatalogueState());

  void toggleCatalogue(){
    state =state.copyWith(isCatalogueOpen: !(state.isCatalogueOpen));
}
  void changeState(int index) {
    state = state.copyWith(stateIndex: index);
  }
}
