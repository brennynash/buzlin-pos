import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services_state.dart';

class ServicesNotifier extends StateNotifier<ServicesState> {
  ServicesNotifier() : super(const ServicesState());

  void toggleServices(){
    state =state.copyWith(isServicesOpen: !(state.isServicesOpen));
}
  void changeState(int index) {
    state = state.copyWith(stateIndex: index);
  }
}
