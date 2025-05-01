// ignore_for_file: unused_field
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {

  ProfileNotifier() : super(const ProfileState());

  changeIndex(int index) {
    state = state.copyWith(selectIndex: index);
  }

}
